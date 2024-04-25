class Post < ApplicationRecord
  belongs_to :user

  has_many :comments, dependent: :destroy

  enum phase: { improvement: 0, development: 1, leaping: 2 }

  validates :title, presence: true
  validates :phase, presence: true
  validates :body, presence: true
  validates :way, presence: true
  validates :investment, presence: true

  def self.search_for(content)
    if content.present?
      Post.where('title LIKE ?', '%'+content+'%')
    else
      Post.none
    end
  end

end
