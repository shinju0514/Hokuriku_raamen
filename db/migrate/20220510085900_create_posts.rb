class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.string :menu, null: false
      t.text :body, null: false
      t.float :rate
      t.timestamps
    end
  end
end
