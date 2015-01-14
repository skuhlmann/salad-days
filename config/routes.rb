Rails.application.routes.draw do

  root 'pages#home'

  resources :markets, path: "", param: :slug, except: [:index, :new, :create] do
    resources :listings, controller: "markets/listings"
  end

  resources :markets, only: [:new, :create]
end
