class Post < ApplicationRecord
  belongs_to :user

  has_many :comments, dependent: :destroy

  enum phase: { improvement: 0, development: 1, leaping: 2 }

  # validates :title, presence: true
  # validates :phase, presence: true
  # validates :body, presence: true
  # validates :way, presence: true
  # validates :investment, presence: true

  validates :title, presence: { message: "タイトルを入力してください" }
  validates :phase, presence: { message: "Phaseを入力してください" }
  validates :body, presence: { message: "Bodyを入力してください" }
  validates :way, presence: { message: "Wayを入力してください" }
  validates :investment, presence: { message: "Investmentを入力してください" }

  def self.search_for(content)
    if content.present?
      Post.where('title LIKE ?', '%'+content+'%')
    else
      Post.none
      # 空のActiveRecordリレーションを返すことで、空欄の場合に何も表示しないようにする
    end
  end

end
