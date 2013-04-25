module Opay
  module Helpers

    module FormHelper

      def opay_form_for(record, options = {}, &block)
        # for future purposes
        payu_form_for(record, options, &block)
      end

      def payment_info(options = {})
        payu_payment_info(options)
      end

    end

  end
end
