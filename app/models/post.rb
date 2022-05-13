class Post < ApplicationRecord
  belongs_to :user
  belongs_to :shop
  belongs_to :area
  has_many :favorites, dependent: :destroy
  has_many :post_tags, dependent: :destroy
  has_many :comments, dependent: :destroy
  validates :menu, presence:true
  validates :body, presence:true

  has_one_attached :post_image

end
