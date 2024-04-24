class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_one_attached :image
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :group_users, dependent: :destroy
  has_many :permits, dependent: :destroy
  
  validates :name, presence: true, length: { maximum: 20 }
  
  def self.search_for(content)
    if content.present?
      User.where('name LIKE ?', '%' + content + '%')
    else
      User.none
      # 空のActiveRecordリレーションを返すことで、空欄の場合に何も表示しないようにする
    end
  end

end
