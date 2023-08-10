Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :users, only: %i[show] do
    resources :members, only: %i[show new create] do
      resources :events, only: %i[show new create]
    end
  end

  # resources :members, only: %i[new create] do
  #   resources :events, only: %i[new create]
  # end
  # resources :events, only: :show
  root to: 'pages#home'
end
