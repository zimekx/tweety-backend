class User < ActiveRecord::Base
  self.inheritance_column = :_type_disabled
  enum type: [:commenter, :creator]

  validates :name, :login, :facebook_id, presence: true
  validates :login, :facebook_id, uniqueness: true
end
