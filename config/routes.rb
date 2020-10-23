# frozen_string_literal: true

Rails.application.routes.draw do
  resources :tags
  resources :projects
  defaults format: :json do
    post 'login', to: 'users#login'
    resources :users, except: [:index]
    resources :time_records, except: %i[show new edit]
  end
end
