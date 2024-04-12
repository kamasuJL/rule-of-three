class Post < ApplicationRecord
  belongs_to :user
  enum phase: { improvement: 0, development: 1, leaping: 2 }
  
  validates :title, presence: true
  validates :phase, presence: true
  validates :body, presence: true
  validates :way, presence: true
  validates :investment, presence: true
  
  def self.search_for(content, method)
    if method == 'perfect'
      Post.where(title: content)
    elsif method == 'forward'
      Post.where('title LIKE ?', content+'%')
    elsif method == 'backward'
      Post.where('title LIKE ?', '%'+content)
    else
      Post.where('title LIKE ?', '%'+content+'%')
    end
  end
  
end
