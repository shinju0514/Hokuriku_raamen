class Area < ApplicationRecord
  has_many :posts, dependent: :destroy
  has_many :shops, dependent: :destroy

  # バリデーション
  validates :prefecture,length: { minimum: 2, maximum: 10 },presence: true
end