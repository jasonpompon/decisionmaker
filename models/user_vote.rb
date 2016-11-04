class User_vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :answer
end
