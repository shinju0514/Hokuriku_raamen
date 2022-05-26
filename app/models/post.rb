class Post < ApplicationRecord
  belongs_to :user
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
  validates :menu, :body, :rate, presence: true

  # Google map api
  geocoded_by :address
  after_validation :geocode

  has_one_attached :post_image


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
