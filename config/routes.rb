Rails.application.routes.draw do
  devise_for :users
  root to:"users#index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :show, :new, :create]
    resources :likes, only: [:create]
  end
  post '/users/:user_id/posts/:id' , to: 'comments#create'
  # Defines the root path route ("/")
end
