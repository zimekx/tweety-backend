class User < ActiveRecord::Base
  has_many :comments

  self.inheritance_column = :_type_disabled
  enum type: [:commenter, :creator]

  validates :name, :login, :facebook_id, presence: true
  validates :login, :facebook_id, uniqueness: true
end
