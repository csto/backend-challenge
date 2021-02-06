class CreateFriendships < ActiveRecord::Migration[6.1]
  def change
    create_table :friendships do |t|
      t.integer :member_a_id, index: true, null: false
      t.integer :member_b_id, index: true, null: false

      t.timestamps
    end

    add_reference :friendships, :member_a_id, foreign_key: { to_table: :members }
    add_reference :friendships, :member_b_id, foreign_key: { to_table: :members }
  end
end
