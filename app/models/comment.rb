class Comment < ActiveRecord::Base
  belongs_to :event

  validates :event_id, :content, presence: true
end
