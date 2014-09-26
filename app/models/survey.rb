class Survey < ActiveRecord::Base
  has_many :responses
  has_many :respondents, through: :responses, class_name: "User"
  belongs_to :creator, class_name: "User"
  has_many :questions

  validates :title, presence: true
end


