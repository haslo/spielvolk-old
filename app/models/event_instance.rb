class EventInstance < ActiveRecord::Base
  has_and_belongs_to_many :games
  belongs_to :event
end
