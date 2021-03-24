Rails.application.routes.draw do
  devise_for :users

  resources :games, only: %i[index]
  resources :predictions, only: %i[index]
  resources :teams do
    member do
      get :leave
      get '/join/:token', to: 'teams#join', as: :join
    end
  end

  resource :dashboard, only: %i[show]

  root 'landing_page#index'
end
