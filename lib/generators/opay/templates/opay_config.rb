Opay.configure do |config|
  config.providers = [:payu, :transferuj, :paypal]

  config.test_mode = true
  # config.process_payments_localy = true if Rails.env.development?

  config.success_url = :success_payment_url
  config.cancel_url = :cancel_payment_url

  # payu configuration
  config.payu_pos_id = ENV['PAYU_POS_ID']
  config.payu_pos_auth_key = ENV['PAYU_POS_AUTH_KEY']
  config.payu_key1 = ENV['PAYU_KEY1']
  config.payu_key2 = ENV['PAYU_KEY2']

  # transferuj configuration
  config.transferuj_user_id = ENV['TRANSFERUJ_USER_ID']
  config.transferuj_secure_code = ENV['TRANSFERUJ_SECURE_CODE']

  # paypal configuration
  config.paypal_login = ENV['PAYPAL_LOGIN']
  config.paypal_password = ENV['PAYPAL_PASSWORD']
  config.paypal_signature = ENV['PAYPAL_SIGNATURE']
  config.paypal_currency = 'EUR'
end
