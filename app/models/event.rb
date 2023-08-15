class Event < ApplicationRecord
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
  belongs_to :member
  has_many :notes, as: :noteable, dependent: :destroy
  has_many_attached :photos
end
