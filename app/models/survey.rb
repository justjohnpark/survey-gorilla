class Survey < ActiveRecord::Base
  has_many :responses
  has_many :respondents, through: :responses, class_name: "User"
  belongs_to :creator, class_name: "User"
  has_many :questions

  validates :title, presence: true

  def self.create_survey(params)
    all_questions = params[:questions]
    survey = Survey.create(title: params[:title], creator_id: params[:creator_id])
    Question.create_questions(all_questions, survey)  
  end

  def self.by_popularity(surveys)
    surveys.sort_by { |survey| survey.respondents.count }.reverse
  end

  def build_stats
    response_object = {}
    self.questions.each do |question|
      choices = {}
      question.choices.each do |choice|
        choices[choice.content] = choice.responses.count
      end
      response_object[question.content] = choices
    end    
    response_object
  end  
end


