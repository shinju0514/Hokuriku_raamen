class CreateShops < ActiveRecord::Migration[6.1]
  def change
    create_table :shops do |t|
      t.string :shop_name, null: false
      t.string :address, null: false
      t.string :bussiness_hour, null: false
      t.boolean :shop_status, null: false, default: false
      t.timestamps
    end
  end
end
