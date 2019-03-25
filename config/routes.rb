# frozen_string_literal: true

Rails.application.routes.draw do
  resources :games, only: %i[index show create destroy] do
    resources :frames, only: %i[index show update] do
      resources :rolls, only: %i[index show create]
    end
  end
end
