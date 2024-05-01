class Tag < ApplicationRecord
  has_many :post_tags, dependent: :destroy
  has_many :post, through: :post_tags
  
  belongs_to :group

  validates :name, presence:true, length:{maximum:50}
end
