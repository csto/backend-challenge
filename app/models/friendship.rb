class Friendship < ApplicationRecord
  belongs_to :member_a, class_name: 'Member'
  belongs_to :member_b, class_name: 'Member'

  after_create :increment_counter_caches
  after_destroy :decrement_counter_caches

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
end
