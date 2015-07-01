class Event < ActiveRecord::Base
  has_many :comments, dependent: :destroy
  belongs_to :user

  JSON_FIELDS = [:id, :name, :description, :twitter_tag]
  COMMENTS_FIELDS = [:event_id, :id, :type, :content, :created_at]

  validates :name, :description, :meetup_id, presence: true

  def self.lightning
    comments = Comment.pluck(*COMMENTS_FIELDS).group_by { |a| a[0] }
    events_with_comments = comments.keys

    pluck(*JSON_FIELDS).map do |event|
      attrs = Hash[JSON_FIELDS.zip(event)]

      attrs[:comments] = if events_with_comments.include?(attrs[:id])
                           comments[attrs[:id]].map { |a| Hash[COMMENTS_FIELDS.zip(a)] }
                         else
                           []
                         end
      attrs
    end
  end

  def as_json(options = {})
    super(only: JSON_FIELDS).merge(comments: comments.map(&:as_json))
  end
end
