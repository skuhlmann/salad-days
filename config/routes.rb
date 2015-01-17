Rails.application.routes.draw do

  root 'pages#home'

  get "/search_results", to: "pages#search_results"

  resources :markets, path: "markets", param: :slug, only: [:show, :edit, :update, :new, :create] do
    resources :listings, controller: "markets/listings", except: [:show, :index]
  end

  resources :users, only: [:show]

  get "/auth/twitter/callback", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
end
