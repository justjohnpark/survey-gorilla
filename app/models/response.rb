class Response < ActiveRecord::Base
  belongs_to :respondent, class_name: "User"
  belongs_to :survey
  belongs_to :question
  belongs_to :choice

  def content
    self.choice.content
  end

  def self.record_responses(params)
    respondent_id = params[:respondent_id]
    survey_id = params[:id]
    params[:response].keys.each do |question_id|
      Response.create(respondent_id: respondent_id , survey_id: survey_id, question_id: question_id, choice_id: params[:response][question_id])
    end    
  end
end
