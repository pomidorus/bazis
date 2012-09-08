BazisDev1::Application.routes.draw do

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


  root :to => 'dash_board#index'
end
