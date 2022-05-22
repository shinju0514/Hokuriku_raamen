class Area < ApplicationRecord
  has_many :posts, dependent: :destroy
  has_many :shops, dependent: :destroy

  # バリデーション
  validates :prefecture, presence: true
end
