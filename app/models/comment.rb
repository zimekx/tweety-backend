class Comment < ActiveRecord::Base
  belongs_to :event

  validates :event_id, :content, presence: true

  def as_json(params = {})
    super(only: [:id, :content, :created_at]).merge(author_name: author_name)
  end
end
