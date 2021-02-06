class Member < ApplicationRecord
  has_many :headings

  validates :name, length: (1..255)
  validates :website_url, length: (1..255)
  validates :website_short_url, length: (0..255), allow_blank: true

  def friendships
    Friendship.where('member_a_id = ? OR member_b_id = ?', id, id)
  end
end
