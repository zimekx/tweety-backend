class Event < ActiveRecord::Base
  validates :name, :description, :meetup_id, presence: true
end
