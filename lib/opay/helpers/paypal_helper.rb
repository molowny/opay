module Opay
  module Helpers

    module PaypalHelper

      def paypal_form_for(record, options = {}, &block)
        record.prepare_payment

        options[:builder] ||= Opay::FormBuilder
        options[:url]  = opay.new_paypal_payment_path
        options[:html] = { id: "paypal_payment_form_#{record.id}", class: 'opay-form opay-paypal-form' }

        form_for(record, options, &block)
      end

      def paypal_payment_info(options = {})
        options[:session_id] ||= object.payment_session_id
        options[:amount]     ||= object.amount

        fields = options.map { |key, val| @template.hidden_field_tag(key, val) }.join("\n")

        fields.html_safe
      end

      def paypal_submit_tag
        @template.image_submit_tag('https://www.paypal.com/pl_PL/i/btn/btn_xpressCheckout.gif')
      end

    end

  end
end
