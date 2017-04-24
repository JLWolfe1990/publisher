Rails.application.routes.draw do
  root to: 'articles#index'
  devise_for :users

  resources :articles, only: [:index, :new, :create, :show]
  resources :topic_requests, only: [:new, :create, :show] do
    post :upvote, on: :member
    post :downvote, on: :member
  end
  resources :searches, only: [:create, :show]

  post 'subscribe', to: 'users#subscribe', as: 'subscribe_users'
end
