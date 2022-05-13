class Post < ApplicationRecord
  belongs_to :user
  belongs_to :shop
  belongs_to :area
  has_many :favorites, dependent: :destroy
  has_many :post_tags, dependent: :destroy
  has_many :comments, dependent: :destroy

  # バリデーション
  validates :menu, :body, :rate, presence: true

  has_one_attached :post_image

  def post_get_image(width, height)
    unless post_image.attached?
    file_path = Rails.root.join('app/assets/images/no_image.png')
    post_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    post_image.variant(resize_to_limit: [width, height]).processed
  end

end
