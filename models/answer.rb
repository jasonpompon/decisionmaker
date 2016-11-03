class Answer < ActiveRecord::Base
  belongs_to :question
  validates :option, length: { minimum: 2 }


  before_create :populate_vote

  private
  def populate_vote
    self.vote = 0
  end

end
