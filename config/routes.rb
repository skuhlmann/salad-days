Rails.application.routes.draw do

  root 'pages#home'

  resources :markets, path: "", param: :slug, except: [:index]

  namespace :markets, as: :market, path: "/:slug" do
    resources :listings
  end
end
