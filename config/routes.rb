Rails.application.routes.draw do

  root 'pages#home'

  get "/search_results", to: "pages#search_results"

  resources :markets, path: "markets", param: :slug, only: [:show, :edit, :update] do
    resources :listings, controller: "markets/listings", except: [:show]
  end

  resources :users, only: [:show] do
    resources :markets, only: [:new, :create, :delete]
  end

  get "/auth/twitter/callback", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
end
