module Opay
  module Helpers

    module FormHelper

      def opay_form_for(record, options = {}, &block)
        # for future purposes
        @payment_provider = options[:provider]

        raise ArgumentError, 'Empty payment provider' if @payment_provider.blank? || Opay.config.providers.include?(@payment_provider) == false

        case @payment_provider
        when :payu
          return payu_form_for(record, options, &block)
        when :transferuj
          return transferuj_form_for(record, options, &block)
        when :paypal
          return paypal_form_for(record, options, &block)
        end

      end

      def payment_info(options = {})
        raise ArgumentError, 'Empty payment provider' if @options[:provider].blank? || Opay.config.providers.include?(@options[:provider]) == false

        case @options[:provider]
        when :payu
          payu_payment_info(options)
        when :transferuj
          transferuj_payment_info(options)
        when :paypal
          paypal_payment_info(options)
        end
      end

    end

  end
end
