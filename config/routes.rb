Rails.application.routes.draw do

  resources :api_cocktail_infos, only: [:index, :show]
  resources :cocktails, only: [:create, :update, :show, :destroy, :index]
  resources :ingredients, only: [:create, :show, :destroy, :index, :update]
  resources :comments, only: [:create, :update, :destroy]
  resources :reviews, only: [:create, :update, :destroy]
  resources :users, only: [:create, :update, :show, :destroy]
  resources :likes, only: [:create, :destroy]

  post "/login", to: "sessions#create", as: "login"
  post "/register", to: "users#create", as: "register"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
