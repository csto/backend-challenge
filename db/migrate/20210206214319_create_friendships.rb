class CreateFriendships < ActiveRecord::Migration[6.1]
  def change
    create_table :friendships do |t|
      t.integer :member_a_id, index: true, null: false, foreign_key: { to_table: :members }
      t.integer :member_b_id, index: true, null: false, foreign_key: { to_table: :members }

      t.timestamps
    end

    add_foreign_key :friendships, :members, column: :member_a_id
    add_foreign_key :friendships, :members, column: :member_b_id
  end
end
