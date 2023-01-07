Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :categories, except: [:update, :edit, :destroy] do
    resources :payments, only: [:new, :create]
  end

  root "home#index"
end