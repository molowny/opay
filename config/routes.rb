Opay::Engine.routes.draw do

  # payu
  scope 'payu' do
    post 'online' => 'payu#online', as: :payu_online

    if Opay.config.process_payments_localy
      patch 'paygw/UTF/NewPayment' => 'payu#paygw', as: :payu_new_payment
    end
  end

  # transferuj
  scope 'transferuj' do
    post 'online' => 'transferuj#online', as: :transferuj_online

    if Opay.config.process_payments_localy
      patch 'secure' => 'transferuj#secure', as: :transferuj_new_payment
    end
  end


  # paypal
  scope 'paypal' do
    patch 'new' => 'paypal#new', as: :paypal_new_payment
    get 'confirm' => 'paypal#confirm', as: :paypal_confirm_payment
  end

  if Opay.config.process_payments_localy
    get 'correct_authorization' => 'payu#correct_authorization', as: :opay_correct_authorization
    get 'wrong_authorizationt' => 'payu#wrong_authorizationt', as: :opay_wrong_authorization
  end

end
