require 'sidekiq/web'

Rails.application.routes.draw do
  constraints ->(request) { request.env["warden"].user&.admin? } do
    mount Avo::Engine, at: Avo.configuration.root_path
  end

  root 'static_pages#home'
  devise_for :users, controllers: {
               omniauth_callbacks: 'users/omniauth_callbacks',
               registrations: 'users/registrations'
             }

  resources :companies, only: %i[show edit update] do
    resources :services
  end

  resources :bookings

  mount Sidekiq::Web => '/sidekiq'
end
