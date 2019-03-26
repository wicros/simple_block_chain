Rails.application.routes.draw do
  root to: 'blockchain#home'

  get "blocks",  to: "blockchain#index"
  post "blocks", to: "blockchain#create"
  get "blocks/new",  to: "blockchain#new"
end
