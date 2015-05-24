class User < ActiveRecord::Base
  enum type: [:commenter, :creator]

  validates :name, :login, :email, presence: true
end
