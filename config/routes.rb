# frozen_string_literal: true

Rails.application.routes.draw do
  resources :vehicles do
    collection do
      get 'search', to: 'vehicles#search'
      get :all_records
    end
    member do
      patch :exit
    end
  end
  root 'vehicles#index'
end
