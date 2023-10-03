Rails.application.routes.draw do
  devise_for :users

  resources :lists do
    resources :items, except: :index do
      member do
        put :complete
      end
    end
  end

  root to: "lists#index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
