Rails.application.routes.draw do
  root to: 'articles#welcome'
  devise_for :users

  resources :articles do
    resources :comments, only: [:new]
  end

  resources :topic_requests, only: [:new, :create, :show, :index] do
    post :upvote, on: :member
    post :downvote, on: :member
  end

  resources :searches, only: [:create, :show]

  resources :comments, only: [:create, :destroy]

  post 'subscribe', to: 'users#subscribe', as: 'subscribe_users'
end
