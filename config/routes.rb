Rails.application.routes.draw do
  devise_for :users
  
  root "pages#show", page: "home"
end
