Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :users, only: %i[index show] do
    resources :members, only: %i[index]
  end

  resources :members, only: %i[index new show create]
  root to: 'pages#home'
end
