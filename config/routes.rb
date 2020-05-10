# frozen_string_literal: true

Rails.application.routes.draw do
  get '/sign_up', to: 'users#new'
  get '/users/:id', to: 'users#show', defaults: { format: 'json' }
  resources :users, except: [:index]
  get '/login', to: 'users#login'

  resources :sessions, only: %i[create destroy]
end
