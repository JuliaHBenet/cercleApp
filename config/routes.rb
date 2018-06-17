Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :clients
  resources :bookings
  resources :rooms
  resources :users

  root 'pages#home'

  resources :bookings do
    member do
      patch 'accept', to: 'bookings#accept'
      patch 'decline', to: 'bookings#decline'
    end
  end

  controller :pages do
    get :home
    get :informes
    get :documents
    get :seccio
    get :calendar
  end

end
