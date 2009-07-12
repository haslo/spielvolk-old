require "digest/sha2"
require "resolv"

class User < ActiveRecord::Base
  EMAIL_PATTERN = /(\S+)@(\S+)/
  SERVER_TIMEOUT = 3 # seconds

  has_and_belongs_to_many :roles
  has_many :profile_associations
  has_many :profiles, :through => :profile_associations
  has_many :events

  validates_uniqueness_of :username
  validates_presence_of :username
  validates_format_of :email, :with => EMAIL_PATTERN

  def validate
    unless errors.on(:email)
      unless valid_domain?(email)
        errors.add(:email, I18n.t('errors.incorrect_domain'))
      end
    end
    # this is less strict than validates_confirmation_of, which doesn't accept nil
    unless @password_var == @password_confirmation
      errors.add(:password, I18n.t('activerecord.errors.messages.confirmation'))
    end
    if !(self.password_salt && self.password_hash) then
      # new records do need a password; old records without a new password just keep the one they have
      errors.add(:password, I18n.t('activerecord.errors.messages.empty'))
    end
  end

  def password
    # will be nil most of the time - we only need it when creating the account for password confirmation
    @password_var
  end

  def password_confirmation
    # will be nil most of the time - we only need it when creating the account for password confirmation
    @password_confirmation
  end

  def password=(pass)
    if pass && (pass != "")
      salt = [Array.new(6){rand(256).chr}.join].pack("m").chomp
      self.password_salt, self.password_hash = salt, Digest::SHA256.hexdigest(pass + salt)
    end
    # create temporary holder, it will be removed once we save
    # (necessary for password confirmation)
    @password_var = pass
  end

  def password_confirmation=(pass)
    # create temporary holder, it will be removed once we save
    @password_confirmation = pass
  end

  def self.authenticate(username, password)
    user = User.find(:first, :conditions => ['username = ?', username])
    if user.blank? || Digest::SHA256.hexdigest(password + user.password_salt) != user.password_hash
      raise "Username or password invalid"
    end
    user
  end

  def save(*)
    if super
      # delete temporary holders again, for security reasons
      @password_var = @password_confirmation = nil
      true
    end
  end

  def valid_domain?(email)
    begin 
      domain = email.match(EMAIL_PATTERN)[2]
      dns = Resolv::DNS.new

      Timeout::timeout(SERVER_TIMEOUT) do 
        # Check the MX records
        mx_records = dns.getresources(domain, Resolv::DNS::Resource::IN::MX)
        mx_records.sort_by { |mx| mx.preference }.each do |mx|
          a_records = dns.getresources(mx.exchange.to_s, Resolv::DNS::Resource::IN::A)
          return true if a_records.any?
        end
        a_records = dns.getresources(domain, Resolv::DNS::Resource::IN::A)
        a_records.any?
      end
    rescue Timeout::Error, Errno::ECONNREFUSED
      false
    end
  end
end
