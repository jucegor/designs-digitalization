Rails.application.routes.draw do
  devise_for :users
  resources :designs

  get '/user', to: "designs#index", as: :user_root
  root to: 'pages#home'
  get '/all_designs', to: 'designs#all_designs', as: :all_designs
  get '/requests', to: 'requests#all_requests', as: :requests
  get '/requests/new', to: 'requests#new'
  get '/requests/:id', to: 'requests#show', as: :request
  post '/requests', to: 'requests#create'
  delete '/requests/:id', to: 'requests#destroy'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
