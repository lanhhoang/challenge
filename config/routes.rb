# frozen_string_literal: true

Rails.application.routes.draw do
  resources :companies do
    resources :members, only: [:index, :create, :destroy], controller: "company_members"
  end
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
