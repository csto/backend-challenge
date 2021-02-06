class Member < ApplicationRecord
  has_many :headings
  has_many :friendships, -> (member) { where('member_a_id = ? OR member_b_id = ?', member.id, member.id) }
  has_many :friends, through: :friendships

  counter_cache :friendships

  validates :name, length: (1..255)
  validates :website_url, length: (1..255)
  validates :website_short_url, length: (0..255), allow_blank: true
end
