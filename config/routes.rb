BazisDev1::Application.routes.draw do

  post "file/upload"
  get "file/file"

  #get "vpfiles/upload"
  #get "vpfiles/index"
  #post "vpfiles/upload"
  #post "secretar/vpfiles/upload"
  #get "secretar/vpfiles/file"
  #post "finansist/vpfiles/upload"
  #get "finansist/vpfiles/file"

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

  devise_for :admins, path_names: {sign_in: "login"}
  devise_for :users, path_names: {sign_in: "login"}

  devise_scope :user do
    get "/login" => "devise/sessions#new"
  end

  match "admin/roles/:id" => "admin/roles#show"
  match "admin/users/:id" => "admin/users#show"

  match 'files', :to => 'finansist/vpfiles#index'
  #match 'files/:id', :to => 'files#file'

  namespace :admin do
    resources :users
    resources :roles
  end

  namespace :finansist do
    #resources :vpfiles
    resources :vipiski
    resources :plategi
    resources :arendators
    resources :dogovora
  end

  #namespace :secretar do
  #  resources :vpfiles
  #end

  root :to => 'dash_board#index'
end
