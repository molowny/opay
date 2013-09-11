module Opay

  module Configuration
    extend ActiveSupport::Concern
    include ActiveSupport::Configurable

    included do
      config_accessor :provider

      # payu configuration
      config_accessor :pos_id
      config_accessor :pos_auth_key
      config_accessor :key1
      config_accessor :key2

      config_accessor :test_mode
      config_accessor :process_payments_localy

      reset_config
    end

    module ClassMethods

      def configure
        yield self
      end

      # Sets configuration back to default
      def reset_config
        configure do |config|
          config.provider = :payu

          # payu configuration
          config.pos_id = 999
          config.pos_auth_key = 'pos_auth_key'
          config.key1 = 'key1'
          config.key2 = 'key2'

          config.test_mode = false
          config.process_payments_localy = false
        end
      end

    end

  end

end
