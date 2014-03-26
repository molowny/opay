Rails.application.routes.draw do
  root to: 'orders#index'
  resources :orders

  get 'success' => 'payments#success', as: :success_payment
  get 'cancel' => 'payments#cancel', as: :cancel_payment

  mount Opay::Engine => '/opay'
end
