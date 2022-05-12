Rails.application.routes.draw do

# 管理者用
  devise_for :admin, skip:[:registrations, :passwords], controllers:{
    sessions: "admin/sessions"
  }

  namespace :admin do
    root :to =>'homes#top'
    get "homes/about"=>'homes#about'
    resources :users, only: [:index, :show, :edit, :update]
    resources :posts, only: [:index, :show, :edit, :update, :destroy]
    resources :shops, only: [:index, :show, :edit, :update, :new, :create, :destroy]
    resources :areas, only: [:index, :create, :destroy]
  end

# ユーザー用
  scope module: :user do
    root :to => 'homes#top'
    get "homes/about" => "homes#about", as: "about"
    devise_for :users,skip: [:passwords], controllers: {registrations: "user/registrations",sessions: 'user/sessions'}
    resources :users, only: [:show, :edit, :update, :unsubscribe]
    resources :posts, only: [:index, :show, :edit, :update, :new, :create, :destroy] do
      resources :post_comments, only: [:create, :destroy]
       resource :favorites, only: [:create, :destroy]
    end
    resources :shops, only: [:index, :show, :edit, :update, :new, :create]
    resources :searches, only: [:search_area, :search_tag, :search_post, :search_shop] do
        get :search_area, on: :collection
        get :search_tag, on: :collection
        get :search_post, on: :collection
        get :search_shop, on: :collection
    end
  end
end
