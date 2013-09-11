Opay.configure do |config|
  config.provider = :payu

  # payu configuration
  config.pos_id = 123456
  config.pos_auth_key = 'DiEKzTD'
  config.key1 = 'c0c4b1a6b72b610f9342ea6820ee3a9c'
  config.key2 = '2af5c662cab479e5471ca76326a57563'

  config.test_mode = true
  config.process_payments_localy = true if Rails.env.development?
end
