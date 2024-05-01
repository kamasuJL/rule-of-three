class Post < ApplicationRecord
  belongs_to :user

  has_many :comments, dependent: :destroy

  enum phase: { improvement: 0, development: 1, leaping: 2 }
  
  has_one_attached :post_image

  validates :title, presence: true
  validates :phase, presence: true
  validates :body, presence: true
  validates :way, presence: true
  validates :investment, presence: true
  
  def get_post_image(width, height)
    unless post_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      post_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    post_image.variant(resize_to_limit: [width, height]).processed
  end

  def self.search_for(content)
    if content.present?
      Post.where('title LIKE ?', '%'+content+'%')
    else
      Post.none
    end
  end
  
  def save_tags(tags)
    current_tags = self.tags.pluck(:name) unless self.tags.nil?
    old_tags = current_tags - tags
    new_tags = tags - current_tags
    # 古いタグを消す
    old_tags.each do |old_name|
      self.tags.delete Tag.find_by(name:old_name)
    end
    # 新しいタグを保存
    new_tags.each do |new_name|
      tag = Tag.find_or_create_by(name:new_name)
      self.tags << tag
    end
  end

end
