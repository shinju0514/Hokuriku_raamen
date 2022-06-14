class Shop < ApplicationRecord

  has_one_attached :shop_image
  has_many :posts, dependent: :destroy
  belongs_to :area

  # バリデーション
  validates :shop_name, length: { maximum: 20 },presence: true
  validates :address, presence: true,uniqueness: true
  validates :bussiness_hour, presence: true
  validate :shop_image_content_type
  enum shop_status: { 閉店: true, 開店: false }

  # Google map api
  geocoded_by :address
  after_validation :geocode

  # 閲覧数
  is_impressionable counter_cache: true

  # スコープ
  scope :latest, -> {order("created_at DESC")}
  scope :updated, -> {order("updated_at DESC")}


  # 店舗画像の設定
  def get_shop_image(width, height)
    unless shop_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpeg')
      shop_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    shop_image.variant(resize_to_limit: [width, height]).processed
  end

  def self.shop_popular
    Shop.includes(:posts).sort{|a,b| b.posts.size <=> a.posts.size }
  end

  def shop_image_content_type
    extension = ['image/png', 'image/jpg', 'image/jpeg']
    errors.add(:shop_image, "の拡張子が間違っています") unless shop_image.content_type.in?(extension)
  end
end
