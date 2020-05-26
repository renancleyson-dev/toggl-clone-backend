# frozen_string_literal: true

Rails.application.routes.draw do
  get '/login', to: 'users#login'

  get '/sign_up', to: 'users#new'
  get '/users/:id', to: 'users#show', defaults: { format: 'json' }
  resources :users, except: [:index] do
    resources :time_records, except: %i[show new edit], defaults: { format: 'json' }
  end
  resources :sessions, only: %i[create destroy]
end
