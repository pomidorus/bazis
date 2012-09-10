BazisDev1::Application.routes.draw do

  get "vpfiles/index"

  get "dogovora/index"
  get "dogovora/show"
  get "arendators/index"
  get "arendators/show"
  get "plategi/index"
  get "plategi/show"
  get "vipiski/index"
  get "vipiski/show"

  get "roles/index"
  get "roles/show"
  get "dash_board/index"

  #get "users/index"
  #get "users/show"
  #get "users/edit"

  devise_for :admins, path_names: {sign_in: "login"}
  devise_for :users, path_names: {sign_in: "login"}

  devise_scope :user do
    get "/login" => "devise/sessions#new"
  end

  match "admin/roles/:id" => "admin/roles#show"
  match "admin/users/:id" => "admin/users#show"

  namespace :admin do
    resources :users
    resources :roles
  end

  namespace :finansist do
    resources :vipiski
    resources :plategi
    resources :arendators
    resources :dogovora
  end

  namespace :secretar do
    resources :vpfiles
  end



  root :to => 'dash_board#index'
end
