module Opay

  module Configuration
    extend ActiveSupport::Concern
    include ActiveSupport::Configurable

    included do
      config_accessor :providers

      # payu configuration
      config_accessor :payu_pos_id
      config_accessor :payu_pos_auth_key
      config_accessor :payu_key1
      config_accessor :payu_key2

      # paypal configuration
      config_accessor :paypal_login
      config_accessor :paypal_password
      config_accessor :paypal_signature
      config_accessor :paypal_currency

      config_accessor :test_mode
      config_accessor :process_payments_localy

      config_accessor :success_url
      config_accessor :cancel_url

      reset_config
    end

    module ClassMethods

      def configure
        yield self
      end

      # Sets configuration back to default
      def reset_config
        configure do |config|
          config.providers = [:payu, :paypal]

          config.success_url = :success_payment_url
          config.cancel_url = :cancel_payment_url

          # payu configuration
          config.payu_pos_id = ENV['PAYU_POS_ID']
          config.payu_pos_auth_key = ENV['PAYU_POS_AUTH_KEY']
          config.payu_key1 = ENV['PAYU_KEY1']
          config.payu_key2 = ENV['PAYU_KEY2']

          # paypal configuration
          config.paypal_login = ENV['PAYPAL_LOGIN']
          config.paypal_password = ENV['PAYPAL_PASSWORD']
          config.paypal_signature = ENV['PAYPAL_SIGNATURE']
          config.paypal_currency = 'EUR'

          config.test_mode = false
          config.process_payments_localy = true if Rails.env.development?
        end
      end

    end

  end

end
