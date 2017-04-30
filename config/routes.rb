Rails.application.routes.draw do

  namespace :api do

    resources :links

  end

  root 'links#index'
  get "/:short_url", to: "links#show", as: :releted_link
  get "compressed/:short_url", to: "links#compressed", as: :shortened
  resources :links #, only: :create

end