class Right < ActiveRecord::Base
  CONTROLLER_PATTERN = /\A\w+\Z/                      # letter-only word
  ACTIONS_PATTERN = /\A((\w+(\,?\;? *)?)*|\*)\Z/      # comma-, semicolon- or space-separated list of letter-only words, or simply '*'

  has_and_belongs_to_many :roles

  validates_presence_of :name, :controller, :actions
  validates_format_of :controller, :with => CONTROLLER_PATTERN
  validates_format_of :actions, :with => ACTIONS_PATTERN
end
