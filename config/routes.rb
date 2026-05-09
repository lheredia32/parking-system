# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :admin do
    resources :users, only: %i[index edit update destroy]
  end

  resource :profile, only: %i[show edit update]
  resource :session
  resources :passwords, param: :token
  resource :registrations, only: %i[new create]

  resources :vehicles do
    collection do
      get 'search', to: 'vehicles#search'
      get :records_by_user
      get 'export_pdf', to: 'vehicles#export_pdf'
    end
    member do
      patch :exit
    end
  end
  root 'vehicles#index'
end
