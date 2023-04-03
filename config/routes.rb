Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  get "/showroom", to: "pages#showroom"
  get "/quienes_somos", to: "pages#quienes_somos"
  get "/politica_de_cambio", to: "pages#politica_de_cambio"
  get "/talleres", to: "pages#talleres"
  get "/eventos", to: "pages#eventos"
  get "/tienda", to: "pages#tienda"
  get "/home2", to: "pages#home2"
  get "/home3", to: "pages#home3"

  resources :workshops, only: [:new, :create, :show]
  resources :contacts, only: [:create]

  resources :events, only: [:show, :new, :create, :edit, :update]

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
