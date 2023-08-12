class Member < ApplicationRecord
  belongs_to :user
  has_many :events, dependent: :destroy
  has_many :notes, as: :noteable, dependent: :destroy
end
