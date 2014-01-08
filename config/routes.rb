Opay::Engine.routes.draw do

  # payu
  scope 'payu' do
    post '/online' => 'payu#online', as: :payu_online

    if Opay.config.process_payments_localy
      patch '/paygw/UTF/NewPayment' => 'payu#paygw', as: :payu_new_payment

      get '/correct_authorization' => 'payu#correct_authorization', as: :payu_correct_authorization
      get '/wrong_authorizationt' => 'payu#wrong_authorizationt', as: :wrong_authorization
    end
  end

end
