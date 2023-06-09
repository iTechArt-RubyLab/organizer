require 'sidekiq/web'

Rails.application.routes.draw do
  devise_for :users, only: :omniauth_callbacks, controllers: {omniauth_callbacks: 'users/omniauth_callbacks'}

  root to: redirect("/#{I18n.default_locale}"), as: :redirected_root
  scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/ do
    constraints ->(request) { request.env["warden"].user&.admin? } do
      mount Avo::Engine, at: Avo.configuration.root_path
      mount Sidekiq::Web => '/sidekiq'
    end

    root 'static_pages#home'
    get 'about', to: 'static_pages#about'

    devise_for :users, controllers: {
      registrations: 'users/registrations'
    }, skip: :omniauth_callbacks

    resources :companies, only: %i[show edit update] do
      resources :services do
        collection do
          get 'search'
        end
      end
    end

    resources :bookings do
      collection do
        get 'admin_export'
        get 'user_export'
      end
    end

    resources :categories, except: :destroy
  end
end
