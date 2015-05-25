class User < ActiveRecord::Base
  self.inheritance_column = :_type_disabled
  enum type: [:commenter, :creator]

  validates :name, :login, :email, presence: true
end
