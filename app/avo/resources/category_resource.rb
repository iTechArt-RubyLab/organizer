class CategoryResource < Avo::BaseResource
  self.title = :id
  self.includes = []

  field :id, as: :id
  field :name, as: :text
  field :status, as: :select, enum: ::Category.statuses
  field :services, as: :has_many
end
