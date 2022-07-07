Rails.application.routes.draw do
  devise_for :users
  resources :designs
  resources :comments, only: %i[show create new edit update destroy]
  resources :answers
  get '/user', to: "designs#index", as: :user_root
  root to: 'pages#home'
  get '/all_designs', to: 'designs#all_designs', as: :all_designs
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
