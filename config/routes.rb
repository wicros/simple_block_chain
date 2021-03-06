Rails.application.routes.draw do
  root to: 'blockchain#home'

  get "blocks",  to: "blockchain#index"
  get "blocks/new",  to: "blockchain#new"
  get "blockchain/new",  to: "blockchain#valid"

  get "transactions",  to: "transactions#index"
  post "transactions", to: "transactions#create"
  get "transactions/new",  to: "transactions#new"
end
