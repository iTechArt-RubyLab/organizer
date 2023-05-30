class UserResource < Avo::BaseResource
  self.title = :id
  self.includes = []

  field :id, as: :id
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
  field :avatar, as: :file, is_image: true
  field :bookings, as: :has_many
end
