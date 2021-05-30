Rails.application.routes.draw do
  devise_for :users
  root 'home#index'
  resources :courses do
    resources :lessons, only: %i[new create show]
  end 
end
