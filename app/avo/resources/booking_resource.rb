class BookingResource < Avo::BaseResource
  self.title = :id
  self.includes = []

  field :id, as: :id
  field :start_at, as: :date_time
  field :end_at, as: :date_time
  field :total_price, as: :number
  field :user_id, as: :number
  field :service_id, as: :number
  field :total_duration, as: :number
  field :user, as: :belongs_to
  field :service, as: :belongs_to
end
