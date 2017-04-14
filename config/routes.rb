Rails.application.routes.draw do

  root 'links#index'
  get "/:short_url", to: "links#show"
  get "compressed/:short_url", to: "links#compressed", as: :shortened
  resources :links #, only: :create

end