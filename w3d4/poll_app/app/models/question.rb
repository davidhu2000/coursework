# == Schema Information
#
# Table name: questions
#
#  id         :integer          not null, primary key
#  body       :text
#  poll_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

class Question < ActiveRecord::Base
  validates :body, :poll_id, presence: true

  belongs_to :poll,
    primary_key: :id,
    foreign_key: :poll_id,
    class_name: :Poll

  has_many :answer_choices,
    primary_key: :id,
    foreign_key: :question_id,
    class_name: :AnswerChoice

  has_many :responses,
    through: :answer_choices,
    source: :responses

  def results
    # N+1
    # count = Hash.new(0)
    # self.answer_choices.each do |choice|
    #   count[choice.body] += choice.responses.count
    # end
    # count

    # 2 Query solution
    # choices = self.answer_choices.includes(:responses)
    # count = Hash.new(0)
    # choices.each do |choice|
    #   count[choice.body] += choice.responses.count
    # end
    # count

    self.answer_choices.select('answer_choices.body, COUNT(responses.user_id) AS total')
        .joins("LEFT OUTER JOIN responses ON responses.answer_choice_id = answer_choices.id")
        .group(:body).pluck('answer_choices.body, COUNT(responses.user_id) AS total')
        .to_h
  end
end

#
# SELECT
#   answer_choices.*, COUNT(responses.user_id)
# FROM
#   answer_choices
# LEFT OUTER JOIN
#   responses ON responses.answer_choice_id = answer_choice.id
# GROUP BY
#   answer_choice.id
