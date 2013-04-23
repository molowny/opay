module Opay
  module Helpers

    module FormHelper

      def opay_form_for(record, options = {}, &block)
        # for future purposes
        payu_form_for(record, options, &block)
      end

    end

  end
end
