class Event < ActiveRecord::Base
  has_and_belongs_to_many :games
  has_many :event_instances
  belongs_to :user
end
