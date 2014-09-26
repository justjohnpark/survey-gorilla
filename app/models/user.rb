class User < ActiveRecord::Base
  has_many :responses, foreign_key: :respondent_id
  has_many :taken_surveys, through: :responses, source: :survey
  has_many :created_surveys, foreign_key: :creator_id, class_name: "Survey"
  has_many :questions, through: :responses
  has_many :selections, through: :responses, source: :choice

  def password
    self.hashed_password
  end

  def password=(new_password)
    if new_password.length > 0
      hashed_password = BCrypt::Password.create(new_password)
    end
  end

  def authenticate(password_input)
    BCrypt::Password.new(self.password) == password_input
  end


  validates :username, presence: true, uniqueness: true
  validates :hashed_password, presence: true
end
