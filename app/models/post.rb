class Post < ApplicationRecord
  belongs_to :user
  has_many :favorites
  has_many :post_tags
  has_many :comments
  has_many :shops
end
