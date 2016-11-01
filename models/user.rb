class User < ActiveRecord::Base
  has_many :question
end
