Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :users, only: %i[index show] do
  end

  resources :members, only: %i[new show create] do
    resources :events, only: %i[new create show]
  end
  root to: 'pages#home'
end
