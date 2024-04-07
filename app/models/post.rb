class Post < ApplicationRecord
  belongs_to :user
  
  # validates :title, presence: true
  # validates :phase, presence: true
  # validates :body, presence: true
  # validates :way, presence: true
  # validates :investment, presence: true
end
