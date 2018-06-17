Rails.application.routes.draw do
  root to: 'photos#index', category: 'favorites'
 
  resources :photos
  resources :categories
  resources :messages
end
