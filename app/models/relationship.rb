class Relationship < ApplicationRecord
  # class_name:Userでユーザーテーブルからデータを持ってくるようにする。
  belongs_to :follower, class_name: "User"
  belongs_to :followed, class_name: "User"
end
