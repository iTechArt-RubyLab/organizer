class UserResource < Avo::BaseResource
  self.title = :id
  self.includes = []
  # self.search_query = -> do
  #   scope.ransack(id_eq: params[:q], m: "or").result(distinct: false)
  # end

  field :id, as: :id
  # Fields generated from the model
  field :email, as: :text
  field :name, as: :text
  field :phone, as: :text
  field :provider, as: :text
  field :uid, as: :text
  field :avatar_url, as: :text
  field :confirmation_token, as: :text
  field :confirmed_at, as: :date_time
  field :confirmation_sent_at, as: :date_time
  field :deleted_at, as: :date_time
  field :role, as: :select, enum: ::User.roles
  field :bookings, as: :has_many
  # add fields here
end
