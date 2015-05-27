class Event < ActiveRecord::Base
  has_many :comments

  validates :name, :description, :meetup_id, presence: true
end
