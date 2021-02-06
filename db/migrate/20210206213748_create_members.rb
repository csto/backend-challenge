class CreateMembers < ActiveRecord::Migration[6.1]
  def change
    create_table :members do |t|
      t.string :name, null: false, index: true
      t.string :website_url, null: false
      t.string :website_short_url
      t.integer :friendships_count, null: false, default: 0

      t.timestamps
    end
  end
end
