class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :profile_image

  # class_name:"Relationship"でRelationshipモデルからデータを取ってくる。
  # has_many:~~の値にはわかりやすいように命名している。
  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy

  has_many :followings, through: :relationships, source: :followed
  has_many :followers, through: :reverse_of_relationships, source: :follower

  has_many :posts, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  # 通知機能
  has_many :active_notifications, class_name: 'Notification', foreign_key: 'visitor_id', dependent: :destroy
  has_many :passive_notifications, class_name: 'Notification', foreign_key: 'visited_id', dependent: :destroy

   # スコープ
  scope :latest, -> {order("created_at DESC")}
  scope :rated, -> {order("rate DESC")}

  # ユーザーの退会ステータス
  enum user_status: { 有効: false, 退会: true }

  # バリデーション
  validates :email, presence: true
  validates :user_name, length: { minimum: 2, maximum: 20 },uniqueness: true, presence: true
  validate :profile_image_content_type

  # プロフィール画像の設定
  def get_profile_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpeg')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    profile_image.variant(resize_to_limit: [width, height]).processed
  end

# ゲストログインの設定
  def self.guest
    find_or_create_by!(user_name: 'guestuser' ,email: 'guest@guest.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.user_name = "guestuser"
    end
  end

# 通知機能
  def create_notification_follow!(current_user)
    temp = Notification.where(["visitor_id = ? and visited_id = ? and action = ? ",current_user.id, id, 'follow'])
    if temp.blank?
      notification = current_user.active_notifications.new(
        visited_id: id,
        action: 'follow'
      )
      notification.save if notification.valid?
    end
  end

    # フォローしたとき
  def follow(user_id)
    relationships.create(followed_id: user_id)
  end
  # フォローを外すとき
  def unfollow(user_id)
    relationships.find_by(followed_id: user_id).destroy
  end
  # フォローしているかどうか
  def following?(user)
    followings.include?(user)
  end

  # 画像のバリデーション
  def profile_image_content_type
    extension = ['image/png', 'image/jpg', 'image/jpeg']
    errors.add(:profile_image, "の拡張子が間違っています") unless profile_image.content_type.in?(extension)
  end

  def was_attached?
    self.profile_image.attached?
  end
end
