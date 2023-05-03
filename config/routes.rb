Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  get "/showroom", to: "pages#showroom"
  get "/quienes_somos", to: "pages#quienes_somos"
  get "/politica_de_cambio", to: "pages#politica_de_cambio"
  get "/talleres", to: "pages#talleres"
  get "/eventos", to: "pages#eventos"
  get "/tienda", to: "pages#tienda"
  get "/dashboard", to: "pages#dashboard"
  get "/product", to: "pages#product"

  resources :workshops, only: [:new, :create, :show, :destroy]
  resources :contacts, only: [:create]
  resources :events, only: [:show, :new, :create, :edit, :update, :destroy]
  resources :items, only: [:new, :create, :destroy]
  resources :billboards, only: [:new, :create, :destroy]

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
