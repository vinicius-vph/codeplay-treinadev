Rails.application.routes.draw do
  root 'home#index'
  
  devise_for :users
  devise_for :students
  
  namespace :admin do
    root 'admin#index'
    resources :courses do
      resources :lessons, only: %i[new create show edit update destroy]
    end
  end

  namespace :student do
    root 'student#index'
    resources :courses, only: %i[index show] do
      resources :lessons, only: %i[show]
      post 'enroll', on: :member
      get 'my_courses', on: :collection
    end 
  end

  resources :courses, only: %i[show]
end
