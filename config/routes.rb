Rails.application.routes.draw do
  resources :tournaments
  root 'landing_page#index'
end
