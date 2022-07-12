class Shop < ApplicationRecord

  has_one_attached :shop_image
  has_many :posts, dependent: :destroy
  belongs_to :area

  # バリデーション
  # 店名は２０文字まで
  validates :shop_name, length: { maximum: 20 },presence: true
  # 同じ住所は登録できないようにする
  validates :address, presence: true,uniqueness: true
  validates :bussiness_hour, presence: true

  # 開店ステータス　デフォルトは'開店'で'閉店'に変更すると一覧画面で表示されなくなる
  enum shop_status: { 閉店: true, 開店: false }

  # Google map api
  geocoded_by :address
  after_validation :geocode
  after_validation :geocode_address

  # 閲覧数
  is_impressionable counter_cache: true

  # スコープ
  scope :latest, -> {order("created_at DESC")}
  scope :updated, -> {order("updated_at DESC")}


# 住所のバリデーション
  def geocode_address
    return if geocoded?
    self.errors.add(:address, 'を入力してください')
  end


  # 店舗画像の設定
  def get_shop_image(width, height)
    unless shop_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpeg')
      shop_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    shop_image.variant(resize_to_limit: [width, height]).processed
  end

  # 投稿数が多い店舗をソートする
  # includesでpostモデルを指定している
  def self.shop_popular
    Shop.includes(:posts).sort{|a,b| b.posts.size <=> a.posts.size }
  end
end
