Rails.application.routes.draw do
  devise_for :users

  resources :games, only: %i[index]
  resources :predictions, only: %i[index]

  root 'landing_page#index'
end
