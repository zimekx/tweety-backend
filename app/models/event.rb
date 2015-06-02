class Event < ActiveRecord::Base
  has_many :comments, dependent: :destroy

  validates :name, :description, :meetup_id, presence: true
end
