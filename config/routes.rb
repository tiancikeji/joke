Joke::Application.routes.draw do
  resources :likes
  resources :myjokes
  resources :feedbacks

  namespace :api do 
    resources :likes
    resources :myjokes
    resources :feedbacks
    match '/myjokes/play' => "myjokes#play", :via => :post
    match '/version/checkVersion' => "myjokes#checkVersion", :via => :get
  end

  authenticated :user do
    root :to => 'home#index'
  end
  root :to => "home#index"
  devise_for :users
  resources :users

end
