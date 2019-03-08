Rails.application.routes.draw do
  root 'static#welcome'
  get  '/login', :to => 'sessions#new', :as => :login
  post '/login', :to => 'sessions#create'
  get 'auth/google_oauth2/callback', :to => 'sessions#create'
  get '/auth/failure', :to => 'sessions#failure'
  delete '/logout', to: 'sessions#destroy', as: 'logout'
  get '/admin/login', to: 'sessions#new', :as => :admin_login
  post '/admin/pets', to: 'admin/pets#create', :as => :admin_pet_create
  patch '/admin/pets/:id(.:format)', to: 'admin/pets#update', :as => :admin_pet_update

  resources :pets, only: [:index]

  namespace :admin do
    resources :pets
    resources :breeds
  end
  
  resources :pets do
    resources :adoptions, only: [:new, :create]
  end


  resources :users do
    resources :pets, only: [:index, :show, :edit, :update]
    resources :adoptions, only: [:destroy]
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
