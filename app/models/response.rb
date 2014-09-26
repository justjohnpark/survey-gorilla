class Response < ActiveRecord::Base
  belongs_to :respondent, class_name: "User"
  belongs_to :survey
  belongs_to :question
  belongs_to :choice
end
