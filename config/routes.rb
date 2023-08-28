Rails.application.routes.draw do
  resources :lists do
    resources :items, except: :index do
      member do
        put :complete
      end
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
