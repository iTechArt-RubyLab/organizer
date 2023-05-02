require 'sidekiq/web'

Rails.application.routes.draw do
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
