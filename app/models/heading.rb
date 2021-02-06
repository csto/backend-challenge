class Heading < ApplicationRecord
  belongs_to :member

  validates :value, length: (1..255)
end
