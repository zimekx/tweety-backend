class Event < ActiveRecord::Base
  has_many :comments, dependent: :destroy
  belongs_to :user

  validates :name, :description, :meetup_id, presence: true
end
