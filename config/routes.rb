Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  resources :designs
  get '/user' => "designs#index", :as => :user_root
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
