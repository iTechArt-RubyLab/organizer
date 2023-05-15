class Company < ApplicationRecord
  has_many :services, dependent: :destroy

  validates :name, presence: true, length: { minimum: 2, maximum: 50 }
  validates :address, presence: true, length: { maximum: 255 }
  validates :phone, phone: true
  validates :description, presence: true, length: { maximum: 500 }

  geocoded_by :address
  after_validation :geocode

end
