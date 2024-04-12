class Feature < ApplicationRecord
  has_many :comments

  validates :magnitude, presence: true, numericality: { greater_than: 0 }
  validates :place, presence: true
  validates :time, presence: true
  validates :tsunami, inclusion: { in: [true, false] }
  validates :mag_type, presence: true
end
