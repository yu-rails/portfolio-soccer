Rails.application.routes.draw do
  resources :trainings, except: [:edit, :update]
  get 'liftings/new', to: 'liftings#new'
  post 'liftings/create', to: 'liftings#create'
  get 'liftings/:id/edit', to: 'liftings#edit'
  patch 'liftings/:id', to: 'liftings#update'
  resources :liftings, only: [:destroy]
  get 'liftings/:id', to: 'liftings#show'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  get 'signup', to: 'users#new'
  post 'users/create', to: 'users#create'
  get 'users/:id/edit', to: 'users#edit'
  post 'users/:id/update', to: 'users#update'
  get 'users/:id', to: 'users#show'
  get '/', to: 'home#top'
  get '/home/about', to: 'home#about'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
