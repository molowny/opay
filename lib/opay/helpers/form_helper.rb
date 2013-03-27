module Opay
  module Helpers

    module FormHelper

      def opay_form_for(record, options = {}, &block)
        options[:builder] ||= Opay::FormBuilder

        form_for(record, options, &block)
      end

    end

  end
end
