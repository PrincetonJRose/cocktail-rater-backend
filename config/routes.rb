Rails.application.routes.draw do
  resources :api_cocktail_infos, only: [:index]
  resources :cocktail_ingredients
  resources :cocktails, only: [:create, :update, :show, :delete, :index]
  resources :ingredients, only: [:create, :show, :delete, :index]
  resources :comments, only: [:create, :update, :delete]
  resources :reviews, only: [:create, :update, :delete]
  resources :users, only: [:create, :update, :show, :delete]
  resources :likes, only: [:create, :delete]
  post "/login", to: "sessions#create", as: "login"
  post "/register", to: "users#create", as: "register"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
