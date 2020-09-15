# frozen_string_literal: true

Rails.application.routes.draw do
  defaults format: :json do
    resources :users, except: [:index] do
      resources :time_records, except: %i[show new edit]
    end
    resources :sessions, only: %i[create destroy]
  end
end
