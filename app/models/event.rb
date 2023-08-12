class Event < ApplicationRecord
  belongs_to :member
  has_many :notes, as: :noteable, dependent: :destroy
end
