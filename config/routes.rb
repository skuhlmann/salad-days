Rails.application.routes.draw do

  root 'pages#home'

  resources :markets, path: "markets", param: :slug, except: [:index, :new, :create] do
    resources :listings, controller: "markets/listings"
  end

  resources :markets, only: [:new, :create]

  resources :users, only: [:show]

  get "/auth/twitter/callback", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
end
