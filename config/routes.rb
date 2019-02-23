Rails.application.routes.draw do
  get 'sessions/new'
  get 'sessions/create'
  get 'sessions/failure'
  root 'static#welcome'
  get   '/login', :to => 'sessions#new', :as => :login
  get '/auth/:provider/callback', :to => 'sessions#create'
  get '/auth/failure', :to => 'sessions#failure'
  get 'logout', to: 'sessions#destroy', as: 'logout'

  resources :pets, only: [:index]



  namespace :admin do
    resources :pets
    resources :breeds
  end

  resources :users do
    resources :pets, only: [:index, :show, :edit]
    resources :adoptions, only: [:new, :show, :index, :create]
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
