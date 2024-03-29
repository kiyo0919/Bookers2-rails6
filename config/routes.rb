Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'homes#top'
  get "/home/about" => "homes#about", as: 'about'

  resources :books, only: [:create, :show, :index, :edit, :destroy, :update] do
    resource :favorites, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
  end
  resources :users do
    member do
      get 'followers'
      get 'followings'
    end
    resource :relationships, only: [:create, :destroy]
  end
  get '/search', to: 'searchs#search'

  resources :messages, only: [:create]
  resources :rooms, only: [:create,:show]
end
