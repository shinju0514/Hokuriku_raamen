class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.integer :user_id
      t.integer :area_id
      t.integer :shop_id
      t.float :latitude
      t.float :longitude
      t.string :address
      t.string :menu, null: false
      t.text :body, null: false
      t.float :rate
      t.integer :impressions_count, default: 0
      t.timestamps
    end
  end
end
