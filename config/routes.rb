Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :clients do
    resources :events, only: [:new, :create]
    get ":lloguer", to: "clients#index", on: :collection
  end
  resources :events, except: [:new, :create]
  resources :rooms
  resources :users

  root 'pages#home'

  resources :events do
    member do
      patch 'accept', to: 'events#accept'
      patch 'decline', to: 'events#decline'
    end
  end

  controller :pages do
    get :home
    get :informes
    get :documents
  end

  get '/redirect', to: 'event#redirect', as: 'redirect'
  get '/calendar', to: 'pages#calendar', as: 'calendar'

end
