# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :games, only: %i[create show] do
    resources :balls, only: %i[create]
  end
end
