Rails.application.routes.draw do
  resources :trainings, except: [:edit, :update] do
    resources :clears, only: [:create, :destroy]
  end
  resources :liftings, except: [:index]
  resources :users, except: [:index, :destroy] do
    member do
      get :trainings, :clears, :favorites
    end
    resources :favorites, only: [:create, :destroy]
    post :confirm, action: :confirm_new, on: :new
  end
  root to: 'home#top'
  get '/home/about', to: 'home#about'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  get 'signup', to: 'users#new'
  get 'users/new/confirm', to: 'home#top'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
