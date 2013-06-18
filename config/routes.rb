Joke::Application.routes.draw do
  resources :likes
  resources :myjokes

  namespace :api do 
    resources :likes
    resources :myjokes
  end

  authenticated :user do
    root :to => 'home#index'
  end
  root :to => "home#index"
  devise_for :users
  resources :users
end
