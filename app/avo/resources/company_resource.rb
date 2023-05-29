class CompanyResource < Avo::BaseResource
  self.title = :id
  self.includes = []

  field :id, as: :id
  field :name, as: :text
  field :address, as: :textarea
  field :phone, as: :text
  field :description, as: :textarea
  field :services, as: :has_many
end
