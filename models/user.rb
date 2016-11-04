class User < ActiveRecord::Base
  validates :username, length: { minimum: 2 }
  validates :password, length: { in: 6..20 } #or should i name it password_digest instead?
  validates :email, uniqueness: true
  has_many :questions
  has_many :user_votes
  has_secure_password
end
