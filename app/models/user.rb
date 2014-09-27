class User < ActiveRecord::Base
  has_many :responses, foreign_key: :respondent_id
  has_many :taken_surveys, through: :responses, source: :survey
  has_many :created_surveys, foreign_key: :creator_id, class_name: "Survey"
  has_many :questions, through: :responses
  has_many :selections, through: :responses, source: :choice
  validates :username, presence: true, uniqueness: true
  validates :hashed_password, presence: true

  def password
    self.hashed_password
  end

  def password=(new_password)
    if new_password.length > 0
      self.hashed_password = BCrypt::Password.create(new_password)
    end
  end

  def authenticate(password_input)
    BCrypt::Password.new(self.password) == password_input
  end

  def created_surveys
    Survey.where(creator_id: self.id).order("created_at DESC")
  end

  def taken_surveys 
    surveys = []
    Response.where(respondent_id: self.id).order("created_at DESC").each do |response| 
      surveys << response.survey
    end
    surveys.uniq    
  end

  def find_responses_for(survey)
    Response.where(respondent: self, survey: survey)
  end
end
