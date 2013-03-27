Rails.application.routes.draw do
  resources :orders
  mount Opay::Engine => '/opay'
end
