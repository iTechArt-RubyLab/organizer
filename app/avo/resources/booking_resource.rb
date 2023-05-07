class BookingResource < Avo::BaseResource
  self.title = :id
  self.includes = []
  # self.search_query = -> do
  #   scope.ransack(id_eq: params[:q], m: "or").result(distinct: false)
  # end

  field :id, as: :id
  # Fields generated from the model
  field :start_at, as: :date_time
  field :end_at, as: :date_time
  field :total_price, as: :number
  field :user_id, as: :number
  field :service_id, as: :number
  field :total_duration, as: :number
  field :user, as: :belongs_to
  field :service, as: :belongs_to
  # add fields here
end
