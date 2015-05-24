class User < ActiveRecord::Base
  enum type: [:commenter, :creator]
end
