Rails.application.routes.draw do
  devise_for :users
  resources :posts

  root "pages#show", page: "home"
end
