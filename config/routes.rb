Rails.application.routes.draw do
  get '/users/:id', to: 'users#show', as: 'user'
  devise_for :users, controllers: {
    registrations: 'registrations'
  }

  devise_scope :user do
    post '/login', to: 'registrations#login'
    delete '/logout', to: 'registrations#logout'
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
