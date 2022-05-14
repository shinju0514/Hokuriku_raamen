class Area < ApplicationRecord
  has_many :posts, dependent: :destroy
  
  # バリデーション
  validates :prefecture, presence: true
end
