class RegularComment < Comment
  belongs_to :user

  validates :user_id, presence: true

  def author_name
    user.name
  end
end