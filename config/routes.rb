Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")

  namespace :api, defaults: { format: :json } do
    resources :recipes, only: [] do
      get :search, on: :collection
    end
  end
end
