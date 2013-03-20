Rails.application.routes.draw do

  resources :products


  mount Opay::Engine => "/opay"
end
