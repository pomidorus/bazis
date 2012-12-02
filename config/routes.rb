BazisDev1::Application.routes.draw do

  post "file/upload"
  get "file/file"

  get "dogovora/index"
  get "dogovora/show"
  get "arendators/index"
  get "arendators/show"
  get "plategi/index"
  get "plategi/all"
  get "plategi/show"
  get "vipiski/index"
  get "vipiski/show"

  get "roles/index"
  get "roles/show"
  get "dash_board/index"

  devise_for :admins, path_names: {sign_in: "login"}
  devise_for :users, path_names: {sign_in: "login"}

  devise_scope :user do
    get "/login" => "devise/sessions#new"
  end

  match "admin/roles/:id" => "admin/roles#show"
  match "admin/users/:id" => "admin/users#show"

  match 'files', :to => 'finansist/vpfiles#index'
  match 'arendators', :to => 'finansist/arendators#index'

  match 'plategi', :to => 'finansist/plategi#index'
  match 'plategi/:id', :to => 'finansist/plategi#show'

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

  root :to => 'dash_board#index'
end
