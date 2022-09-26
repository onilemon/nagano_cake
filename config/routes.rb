Rails.application.routes.draw do
  devise_for :customers,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}
  scope module: :public do
    resources :items, only: [:index, :show]
    resources :customers, only: [:show, :edit, :update]
    resources :cart_items, only: [:create, :index, :update, :destroy]
    resources :orders, only: [:new, :create, :index, :show]
    resources :addresses
  end
  root to: 'public/homes#top'
  get "/about" => "public/homes#about"
  get "/customers/unsubscribe" => "public/customers#unsubscribe"
  patch "/customers/withdrawal" => "public/customers#withdrawal"
  delete "/cart_items/destory_all" => "public/cart_items#destory_all"
  post "/orders/confirm" => "public/orders#confirm"
  get "/orders/complete" => "public/orders#complete"

  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}

  namespace :admin do
    root to: 'homes#top'
    resources :items
    resources :genres, only: [:create, :index, :edit, :update]
    resources :customers, only: [:index, :show, :edit, :update]
    resources :orders, only: [:show, :update]
    resources :order_details, only: [:update]

  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
