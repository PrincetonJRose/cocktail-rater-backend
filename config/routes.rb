Rails.application.routes.draw do
  resources :api_cocktail_infos
  resources :cocktail_ingredients
  resources :cocktails
  resources :ingredients
  resources :comments
  resources :reviews
  resources :users
  resources :likes
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
