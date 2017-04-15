Rails.application.routes.draw do
  root to: 'articles#index'
  devise_for :users

  resources :articles, only: [:index, :new, :create, :show]
end
