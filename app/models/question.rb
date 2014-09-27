class Question < ActiveRecord::Base
  has_many :choices
  has_many :responses
  belongs_to :survey

  validates :content, presence: true

  def self.create_questions(questions, survey)
    questions.each_value do |value|
      question_text = value[:question]
      all_choices = value[:options]
      question = Question.create(content: question_text, survey_id: survey.id)
      all_choices.each_value do |value|
        Choice.create(content: value, question_id: question.id)
      end
    end      
  end
end
