Rails.application.routes.draw do
  
  
  get 'favorites/create'
  get 'favorites/destroy'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'toppages#index'
  
  get 'signup', to: 'users#new'
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  resources :users, except: [:destroy] do
    member do
      get :likes
    end
  end
  
  resources :posts
  
  resources :favorites, only: [:create, :destroy]
  
end
