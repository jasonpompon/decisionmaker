class Question < ActiveRecord::Base
  belongs_to :user
  has_many :answers
  has_many :user_votes

  validates :content, length: { minimum: 2 }

  before_save :generate_timestamp
  def generate_timestamp
    self.time = DateTime.now
  end
end
