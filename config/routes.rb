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
    resources :posts, only: [:index, :show, :edit, :update, :destroy] do
      # resources :comments, only: [:index]
    end
    resources :comments, only: [:index, :destroy]
  end
  
  # 顧客用URL /users/sign_in ...
  devise_for :users,skip: [:passwords], controllers: {
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
    # namespace :users doにするとルーティングエラー
    #   resources only: [:edit, :show, :update, :destroy] do
    #     get 'unsubscribe' => 'users#unsubscribe'
    #     patch 'withdraw' => 'users#withdraw'
    #   end
    # end
    resources :users, only: [:edit, :show, :update, :destroy, :index] do
      get 'unsubscribe' => 'users#unsubscribe'
      patch 'withdraw' => 'users#withdraw'
    end
    
    resources :posts do
      resources :comments, only: [:create]
    end
    resources :comments, only: [:destroy]
    
  end

end
