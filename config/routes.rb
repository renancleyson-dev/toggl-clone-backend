# frozen_string_literal: true

Rails.application.routes.draw do
  defaults format: :json do
    post 'login', to: 'users#login'
    get 'users/me', to: 'users#show'
    resources :tags
    resources :projects
    resources :users, except: %i[index show]
    resources :time_records, except: %i[show new edit]
  end
end
