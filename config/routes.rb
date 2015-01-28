Rails.application.routes.draw do

  root 'pages#home'

  resources :search_results, only: [:index]

  resources :markets, path: "markets", param: :slug, only: [:show, :edit, :update, :new, :create] do
    resources :listings, controller: "markets/listings", except: [:show, :index, :destroy]
  end

  post "/flag", to: "markets#flag"
  delete "/flag", to: "markets#unflag"

  resources :users, only: [:show]

  get "/contact", to: "markets/listings#contact"
  get "/tweet", to: "markets/listings#tweet"

  get "/auth/twitter/callback", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
end
