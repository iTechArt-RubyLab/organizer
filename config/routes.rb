Rails.application.routes.draw do
  root 'static_pages#home'
  devise_for :users, controllers: {
               omniauth_callbacks: 'users/omniauth_callbacks'
             }

  resources :companies, only: %i[show edit update] do
    resources :services
  end
end
