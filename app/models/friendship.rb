class Friendship < ApplicationRecord
  belongs_to :member_a, class_name: 'Member'
  belongs_to :member_b, class_name: 'Member'

  after_create :increment_counter_caches
  after_destroy :decrement_counter_caches

  def self.friends?(id1, id2)
    Friendship.where('(member_a_id = ? AND member_b_id = ?) OR (member_a_id = ? AND member_b_id = ?)', id1, id2, id2, id1).present?
  end

  def increment_counter_caches
    members = Member.where(id: [member_a_id, member_b_id])

    members.each do |member|
      member.increment!(:friendships_count)
    end
  end

  def decrement_counter_caches
    members = Member.where(id: [member_a_id, member_b_id])

    members.each do |member|
      member.decrement!(:friendships_count)
    end
  end

  def friend_of(member_id)
    if member_a_id == member_id
      Member.find(member_b_id)
    else
      Member.find(member_a_id)
    end
  end
end
