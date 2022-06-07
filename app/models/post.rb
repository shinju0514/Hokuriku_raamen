class Post < ApplicationRecord
  belongs_to :user
  # レビューを投稿する際にお店がないと投稿できないのは使いにくいので、
  # nilでも保存できるようにし、投稿編集画面で店舗を選び直せるようにした。
  belongs_to :shop,optional: true
  belongs_to :area
  has_many :favorites, dependent: :destroy
  has_many :post_tags, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :tags, through: :post_tags

  # スコープ
  scope :latest, -> {order("created_at DESC")}
  scope :rated, -> {order("rate DESC")}
  scope :get_posts_sort_of_CreateDate, -> (number_of_display) {order("created_at": :desc).limit(number_of_display)}

  # バリデーション
  validates :menu, length: { maximum: 20 },presence: true
  validates :body, length: { maximum: 200 },presence: true
  validates :rate, presence: true

  # Google map api
  # addressカラムに住所を入力することで、
  geocoded_by :address
  after_validation :geocode

  # 投稿画像の指定
  has_one_attached :post_image

  # 閲覧数
  is_impressionable counter_cache: true

# 投稿画像の設定
  def post_get_image(width, height)
    unless post_image.attached?
    file_path = Rails.root.join('app/assets/images/no_image.jpeg')
    post_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg/HEIC')
    end
    post_image.variant(resize_to_limit: [width, height]).processed
  end

# ユーザーいいねをしているかを判定するメソッド
  def favorited_by?(user)
    # exists?メソッドでuser_idが存在しているかを判定している。
    favorites.exists?(user_id: user.id)
  end
end
