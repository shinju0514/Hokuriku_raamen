class CreateShops < ActiveRecord::Migration[6.1]
  def change
    create_table :shops do |t|
      t.integer :area_id
      t.string :shop_name, null: false
      t.string :address
      t.float :latitude
      t.float :longitude
      t.string :bussiness_hour, null: false
      t.boolean :shop_status, null: false, default: false
      t.integer :impressions_count, default: 0
      t.timestamps
    end
  end
end
