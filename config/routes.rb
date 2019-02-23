Rails.application.routes.draw do
  root 'static#welcome'
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
