FactoryBot.define do
  factory :user do
    name { 'User' }
    email { 'user@example.com' }
    password { 'Password' }
    password_confirmation { password }
    phone { '+37529123-45-67' }
    role { 0 }
  end
end
