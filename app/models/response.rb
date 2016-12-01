# == Schema Information
#
# Table name: responses
#
#  id               :integer          not null, primary key
#  user_id          :integer
#  answer_choice_id :integer
#  created_at       :datetime
#  updated_at       :datetime
#

class Response < ActiveRecord::Base
  validates :user_id, :answer_choice_id, presence: true
  validate :not_duplicate_response
  validate :author_cant_respond

  belongs_to :answer_choice,
    primary_key: :id,
    foreign_key: :answer_choice_id,
    class_name: :AnswerChoice

  belongs_to :respondent,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :User

  has_one :question,
    through: :answer_choice,
    source: :question

  def sibling_responses
    AnswerChoice.find(self.answer_choice_id).question.responses.where.not(id: self.id)
  end

  def respondent_already_answered?
    sibling_responses.exists?(user_id: self.user_id)
  end

  def not_duplicate_response
    if respondent_already_answered?
      errors[:user] << "cannot answer question twice."
    end
  end

  def author_cant_respond
    if find_author_id == self.user_id
      errors[:author] << "cannot respond to own poll"
    end
  end

  def find_author_id
    AnswerChoice.find(self.answer_choice_id).question.poll.author_id
  end

end
