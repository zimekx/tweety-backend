class MeetupComment < Comment
  validates :external_source_id, :external_user_id, :external_user_name, presence: true

  def author_name
    external_user_name
  end

  def user
    nil
  end
end