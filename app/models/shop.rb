class Shop < ApplicationRecord

  has_one_attached :shop_image
  has_many :posts
end
