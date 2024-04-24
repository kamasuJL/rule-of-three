Rails.application.routes.draw do
  # devise_for :admins
  # devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  # 管理者用URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }
  
  namespace :admin do
    root 'homes#top'
    resources :users, only: [:index, :show, :edit, :update]
    resources :posts, only: [:index, :show, :edit, :update, :destroy]
    resources :comments, only: [:index, :destroy]
    resources :groups, only: [:index, :destroy]
  end
  
  # 顧客パスワード再設定　追加
  # 顧客用URL /users/sign_in ...
  devise_for :users, controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }
  
  scope module: :public do
    # devise signup時のエラー解消
    # get "users" => redirect("/users/sign_up")
    root 'homes#top'
    get '/about' => 'homes#about'
    get 'mypage/' => 'users#mypage'
    get '/search' => 'searches#search'
    
    resources :users, only: [:edit, :show, :update, :destroy, :index] do
      get 'unsubscribe' => 'users#unsubscribe'
      patch 'withdraw' => 'users#withdraw'
    end
    
    resources :posts do
      resources :comments, only: [:create]
    end
    
    resources :comments, only: [:destroy]
    resources :groups, only: [:new, :index, :show, :create, :edit, :update] do
      resource :group_users, only: [:create, :destroy]
      resources :event_notices, only: [:new, :create]
      get "event_notices" => "event_notices#sent"
      resource :permits, only: [:create, :destroy]
    end
    
    get "groups/:id/permits" => "groups#permits", as: :permits
    
  end
end
