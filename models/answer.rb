class Answer < ActiveRecord::Base
  belongs_to :question
  validates :option, length: { minimum: 2 }
  has_many :user_votes
  before_create :populate_vote

  private
  def populate_vote
    self.vote = 0
  end

end
