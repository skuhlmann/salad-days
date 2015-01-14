Rails.application.routes.draw do

  root 'pages#home'

  resources :markets, path: "", param: :slug, except: [:index, :new, :create]

  resources :markets, only: [:new, :create]

  namespace :markets, as: :market, path: "/:slug" do
    resources :listings
  end
end
