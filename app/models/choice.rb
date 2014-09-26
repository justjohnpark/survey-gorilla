class Choice < ActiveRecord::Base
  has_many :responses
  belongs_to :question

  validates :content, presence: true
end
