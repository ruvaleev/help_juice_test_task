# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'articles#index'

  get 'search', to: 'articles#search'
  delete 'article_queries', to: 'article_queries#destroy'

  resources :article_queries, only: :create
end
