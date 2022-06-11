class Post < ApplicationRecord
  belongs_to :user
  # レビューを投稿する際にお店がないと投稿できないのは使いにくいので、
  # nilでも保存できるようにし、投稿編集画面で店舗を選び直せるようにした。
  belongs_to :shop,optional: true
  belongs_to :area
  has_many :favorites, dependent: :destroy
  has_many :post_tags, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :tags, through: :post_tags, dependent: :destroy
  has_many :notifications, dependent: :destroy

  # スコープ
  scope :latest, -> {order("created_at DESC")}
  scope :rated, -> {order("rate DESC")}
  scope :get_posts_sort_of_CreateDate, -> (number_of_display) {order("created_at": :desc).limit(number_of_display)}
  scope :views, -> {order("impressions_count DESC")}

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

  def self.post_favorites
    Post.includes(:favorites).sort{|a,b| b.favorites.size <=> a.favorites.size}
  end

  def self.post_comments
    Post.includes(:post_comments).sort{|a,b| b.post_comments.size <=> a.post_comments.size}
  end

  # 通知機能
  def create_notification_favorite!(current_user)
    # すでに「いいね」されているか検索
    temp = Notification.where(["visitor_id = ? and visited_id = ? and post_id = ? and action = ? ", current_user.id, user_id, id, 'favorite'])
    # いいねされていない場合のみ、通知レコードを作成
    if temp.blank?
      notification = current_user.active_notifications.new(
        post_id: id,
        visited_id: user_id,
        action: 'favorite'
      )
      # 自分の投稿に対するいいねの場合は、通知済みとする
      if notification.visitor_id == notification.visited_id
        notification.checked = true
      end
      notification.save if notification.valid?
    end
  end

  def create_notification_post_comment!(current_user, post_comment_id)
    # 自分以外にコメントしている人をすべて取得し、全員に通知を送る
    temp_ids = PostComment.select(:user_id).where(post_id: id).where.not(user_id: current_user.id).distinct
    temp_ids.each do |temp_id|
      save_notification_post_comment!(current_user, post_comment_id, temp_id['user_id'])
    end
    # まだ誰もコメントしていない場合は、投稿者に通知を送る
    save_notification_post_comment!(current_user, post_comment_id, user_id) if temp_ids.blank?
  end

  def save_notification_post_comment!(current_user, post_comment_id, visited_id)
    # コメントは複数回することが考えられるため、１つの投稿に複数回通知する
    notification = current_user.active_notifications.new(
      post_id: id,
      post_comment_id: post_comment_id,
      visited_id: visited_id,
      action: 'post_comment'
    )
    # 自分の投稿に対するコメントの場合は、通知済みとする
    if notification.visitor_id == notification.visited_id
      notification.checked = true
    end
    notification.save if notification.valid?
  end

end
