Rails.application.routes.draw do

  root 'pages#home'

  resources :markets, only: [:index]

  resources :farmers_markets, only: [:index]

  resources :search_results, only: [:index]

  resources :markets, path: "markets", param: :slug, only: [:show, :edit, :update, :new, :create] do
    resources :listings, controller: "markets/listings", except: [:show, :index, :destroy]
  end

  resources :users, only: [:show]

  get "/contact", to: "markets/listings#contact"

  get "/auth/twitter/callback", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
end
