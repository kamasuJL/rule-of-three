class Post < ApplicationRecord
  belongs_to :user
  enum phase: { improvement: 0, development: 1, leaping: 2 }
  
  validates :title, presence: true
  validates :phase, presence: true
  validates :body, presence: true
  validates :way, presence: true
  validates :investment, presence: true
end
