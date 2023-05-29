class ServiceResource < Avo::BaseResource
  self.title = :id
  self.includes = []

  field :id, as: :id
  field :name, as: :text
  field :description, as: :textarea
  field :duration, as: :number
  field :price, as: :number
  field :company_id, as: :number
  field :category_id, as: :number
  field :quantity, as: :number
  field :opening_time, as: :text
  field :closing_time, as: :text
  field :status, as: :select, enum: ::Service.statuses
  field :image, as: :file, is_image: true
  field :company, as: :belongs_to
  field :bookings, as: :has_many
  field :category, as: :belongs_to
end
