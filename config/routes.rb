Rails.application.routes.draw do
  # ユーザー用
  scope module: 'user' do
    devise_for :users,skip: [:passwords], controllers: {registrations: "user/registrations",sessions: 'user/sessions'}
    root :to => 'homes#top'
    get "homes/about" => "homes#about", as: "about"
    resources :users, only: [:show, :edit, :update, :unsubscribe]
    resources :posts, only: [:index, :show, :edit, :update, :new, :create, :destroy] do
      resources :post_comments, only: [:create, :destroy]
       resource :favorites, only: [:create, :destroy]
    end

    resources :shops, only: [:index, :show, :edit, :update, :new, :create]
    resources :areas, only: [:index, :create, :destroy]
    resources :searches, only: [:search_area, :search_tag, :search_post, :search_shop] do
        get :search_area, on: :collection
        get :search_tag, on: :collection
        get :search_post, on: :collection
        get :search_shop, on: :collection
    end
  end

  # 管理者用
  devise_for :admin,skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }

  namespace :admin do
    root :to =>'homes#top'

    resources :users, only: [:index, :show, :edit, :update]
    resources :posts, only: [:index, :show, :edit, :update, :destroy]
    resources :shops, only: [:index, :show, :edit, :update, :new, :create, :destory]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
