class Service < ApplicationRecord
  searchkick

  belongs_to :company
  has_many :bookings
  belongs_to :category
  enum :status, { active: 0, archived: 1 }
  has_one_attached :image, dependent: :destroy

  validates :name, presence: true, length: { maximum: 100 }
  validates :description, presence: true, length: { maximum: 500 }
  validates :duration, presence: true, numericality: { greater_than: 0, only_integer: true }
  validates :price, presence: true, numericality: { greater_than: 0 }
end
