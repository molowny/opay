Opay::Engine.routes.draw do

  # payu
  scope 'payu' do
    post '/online' => 'payu#online', as: :payu_online
  end

end
