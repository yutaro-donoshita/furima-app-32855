Rails.application.routes.draw do
  devise_for :users
  root to: 'items#index'

  resources :items, only: [ :create, :new, :show, :edit, :update, :destroy ] do
    resources :transactions, only: [ :new, :create ]
  end
end