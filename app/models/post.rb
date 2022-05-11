class Post < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :post_tags, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :shops, dependent: :destroy
  validates :menu, presence:true
  validates :body, presence:true

  has_one_attached :post_image

end
