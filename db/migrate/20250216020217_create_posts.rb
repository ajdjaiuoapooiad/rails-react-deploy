class CreatePosts < ActiveRecord::Migration[7.2]
  def change
    create_table :posts do |t|
      t.string :title
      t.string :category
      t.integer :income

      t.timestamps
    end
  end
end
