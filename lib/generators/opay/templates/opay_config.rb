Opay.configure do |config|
  config.providers = [:payu, :paypal]

  config.test_mode = true
  # config.process_payments_localy = true if Rails.env.development?

  # payu configuration
  config.payu_pos_id = ENV['PAYU_POS_ID']
  config.payu_pos_auth_key = ENV['PAYU_POS_AUTH_KEY']
  config.payu_key1 = ENV['PAYU_KEY1']
  config.payu_key2 = ENV['PAYU_KEY2']

  # paypal configuration
  config.paypal_login = ENV['PAYPAL_LOGIN']
  config.paypal_password = ENV['PAYPAL_PASSWORD']
  config.paypal_signature = ENV['PAYPAL_SIGNATURE']
end
