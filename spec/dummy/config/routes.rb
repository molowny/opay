Rails.application.routes.draw do
  root to: 'orders#index'
  resources :orders
  mount Opay::Engine => '/opay'
end
