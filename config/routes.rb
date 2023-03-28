Rails.application.routes.draw do
  root to: "pages#home"
  get "/showroom", to: "pages#showroom"
  get "/quienes_somos", to: "pages#quienes_somos"
  get "/politica_de_cambio", to: "pages#politica_de_cambio"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
