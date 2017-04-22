Rails.application.routes.draw do
  root to: 'articles#index'
  devise_for :users

  resources :articles, only: [:index, :new, :create, :show]
  resources :topic_requests, only: [:new, :create, :show]
  resources :searches, only: [:create, :show]
end
