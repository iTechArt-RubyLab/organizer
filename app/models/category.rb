class Category < ApplicationRecord
  enum :status, { active: 0, archived: 1 }
  has_many :services
end
