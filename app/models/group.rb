class Group < ApplicationRecord
  has_many :group_users, dependent: :destroy
  belongs_to :owner, class_name: 'User'
  has_many :users, through: :group_users

  validates :name, presence: true, length: { in: 1..9 }
  validates :introduction, presence: true, length: { in: 1..99 }
  has_one_attached :group_image
  
  def is_owned_by?(user)
    owner.id == user.id
  end
end
