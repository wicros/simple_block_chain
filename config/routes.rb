Rails.application.routes.draw do
  root to: 'blockchain#home'

  get "blocks",  to: "blockchain#index"
  post "blocks", to: "blockchain#create"
  get "blocks/new",  to: "blockchain#new"

  get "transactions",  to: "transactions#index"
  post "transactions", to: "transactions#create"
  get "transactions/new",  to: "transactions#new"
end
