class Notification < ApplicationRecord
  default_scope -> { order(created_at: :desc) }

  # optional trueでnilを許可している。
  belongs_to :post, optional: true
  belongs_to :post_comment, optional: true

# 通知を送る側のユーザーと送られる側のユーザーのアソシエーション
# class_name: 'User' でユーザーモデルを参照している
  belongs_to :visitor, class_name: 'User', foreign_key: 'visitor_id', optional: true
  belongs_to :visited, class_name: 'User', foreign_key: 'visited_id', optional: true
end
