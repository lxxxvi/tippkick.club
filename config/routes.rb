Rails.application.routes.draw do
  devise_for :users
  resources :tournaments
  root 'landing_page#index'
end
