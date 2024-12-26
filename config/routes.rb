# frozen_string_literal: true

Rails.application.routes.draw do
  root 'vehicles#index'
  resources :vehicles, only: %i[index create] do
    member do
      patch :exit
    end
  end
end
