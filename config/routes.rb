Rails.application.routes.draw do
  root 'home#index'
  resources :courses, only: %i[index]
end
