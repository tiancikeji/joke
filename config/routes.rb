Joke::Application.routes.draw do
  resources :likes
  resources :myjokes

  namespace :api do 
    resources :likes
    resources :myjokes
    match '/myjokes/photo' => "myjokes#photo", :via => :post
    match '/myjokes/audio' => "myjokes#audio", :via => :post
  end

  authenticated :user do
    root :to => 'home#index'
  end
  root :to => "home#index"
  devise_for :users
  resources :users

end
