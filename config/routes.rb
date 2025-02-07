# frozen_string_literal: true

Rails.application.routes.draw do
  resource :profile, only: %i[show edit update]
  resource :session
  resources :passwords, param: :token
  resource :registrations, only: %i[new create]

  resources :vehicles do
    collection do
      get 'search', to: 'vehicles#search'
      get :records_by_user
    end
    member do
      patch :exit
    end
  end
  root 'vehicles#index'
end
