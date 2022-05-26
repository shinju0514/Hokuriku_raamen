Rails.application.routes.draw do

  namespace :user do
    get 'relationships/followings'
    get 'relationships/followers'
  end
  get 'favorites/create'
  get 'favorites/destroy'
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

# ゲストログイン用
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end

# ユーザー用
  scope module: :user do
    root :to => 'homes#top'
    get "homes/about" => "homes#about", as: "about"
    devise_for :users,skip: [:passwords], controllers: {registrations: "user/registrations",sessions: 'user/sessions'}
    resources :users, only: [:show, :edit, :update] do
      # フォローフォロワーの記述
    resource :relationships, only: [:create, :destroy]
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
      patch :defection, on: :collection
    end
    resources :posts, only: [:index, :show, :edit, :update, :new, :create, :destroy] do
      resources :post_comments, only: [:create, :destroy]
      resource :favorites, only: [:create, :destroy]
        collection do
        get 'search'
      end
    end
    get 'maps/index'
    resources :maps, only: [:index]
    resources :shops, only: [:index, :show, :edit, :update, :new, :create] do
      collection do
        get 'search'
      end
      collection do
        get 'map'
      end
    end
    resources :areas, onbly: [:index] do
      collection do
        get 'search'
      end
    end
  end
end
