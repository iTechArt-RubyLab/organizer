class ServiceResource < Avo::BaseResource
  self.title = :id
  self.includes = []
  # self.search_query = -> do
  #   scope.ransack(id_eq: params[:q], m: "or").result(distinct: false)
  # end

  field :id, as: :id
  # Fields generated from the model
  field :name, as: :text
  field :description, as: :textarea
  field :duration, as: :number
  field :price, as: :number
  field :company_id, as: :number
  field :quantity, as: :number
  field :status, as: :select, enum: ::Service.statuses
  field :company, as: :belongs_to
  field :bookings, as: :has_many
  # add fields here
end
