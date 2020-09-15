# frozen_string_literal: true

Rails.application.routes.draw do
  defaults format: :json do
    post 'login', to: 'users#login'
    resources :users, except: [:index] do
      resources :time_records, except: %i[show new edit]
    end
  end
end
