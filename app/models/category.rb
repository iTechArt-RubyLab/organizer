class Category < ApplicationRecord
  enum :status, { active: 0, archived: 1 }
  has_many :services, dependent: :nullify
  validates :name, presence: true
end
