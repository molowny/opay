# WebMock.disable! if Rails.env.development?

Opay.configure do |config|
  config.providers = [:payu, :transferuj, :paypal]

  config.success_url = :root_url
  config.cancel_url = :root_url

  # payu configuration
  config.payu_pos_id = 123456
  config.payu_pos_auth_key = 'DiEKzTD'
  config.payu_key1 = 'c0c4b1a6b72b610f9342ea6820ee3a9c'
  config.payu_key2 = '2af5c662cab479e5471ca76326a57563'

  # payu configuration
  config.transferuj_user_id = 16059
  config.transferuj_secure_code = 'EdDXG7F4L86svhcR'

  # paypal configuration
  config.paypal_login = 'ollownia-facilitator_api1.gmail.com'
  config.paypal_password = '1395743145'
  config.paypal_signature = 'AGUkzh-MeQY9FWOCQ5.UwnNAI5EgABkxUU7ynmHt9IbLYXd5FwKiwy6K'
  config.paypal_currency = 'EUR'

  config.test_mode = true
  config.process_payments_localy = false if Rails.env.development?
end
