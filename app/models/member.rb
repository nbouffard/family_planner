class Member < ApplicationRecord
  belongs_to :user
  has_many :events, dependent: :destroy
  accepts_nested_attributes_for :events, allow_destroy: true
  has_many :notes, as: :noteable, dependent: :destroy
  has_one_attached :photo
end
