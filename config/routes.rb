Opay::Engine.routes.draw do

  # payu
  # scope :payu do
  #   post '/online' => 'payu#online', as: online
  # end
  post '/online' => 'payu#online', as: online
end
