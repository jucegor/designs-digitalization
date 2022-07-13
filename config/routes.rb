Rails.application.routes.draw do
  root to: 'pages#home'
  devise_for :users

  resources :comments, only: %i[show create new edit update destroy]
  resources :answers

  get '/user', to: "designs#index", as: :user_root
  resources :designs
  get '/all_designs', to: 'designs#all_designs', as: :all_designs
  resources :requests, only: %i[new show edit update create destroy]
  get '/requests', to: 'requests#all_requests', as: :all_requests
  get '/new_project', to: 'requests#new_project', as: :new_project

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
