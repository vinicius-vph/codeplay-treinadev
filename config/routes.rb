Rails.application.routes.draw do
  root 'home#index'

  devise_for :users

  namespace :admin do
    resources :courses
  end

  resources :courses, only: [:show] do
    resources :lessons, only: %i[new create show]
    post 'enroll', on: :member
    get 'my_courses', on: :collection
  end 
end
