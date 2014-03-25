module Opay
  module Helpers

    module PayuHelper

      def payu_form_for(record, options = {}, &block)
        record.prepare_payment

        options[:builder] ||= Opay::FormBuilder
        options[:url]  = Opay::Providers::Payu.url(:new_payment)
        options[:html] = { id: "payu_payment_form_#{record.id}", class: 'opay-form opay-payu-form' }

        form_for(record, options, &block)
      end

      def payu_payment_info(options = {})
        options[:first_name]   ||= object.first_name
        options[:last_name]    ||= object.last_name
        options[:email]        ||= object.email

        options[:pos_id]       ||= Opay.config.payu_pos_id
        options[:pos_auth_key] ||= Opay.config.payu_pos_auth_key
        options[:session_id]   ||= object.payment_session_id

        options[:amount]       ||= object.amount
        options[:desc]         ||= object.payment_description
        options[:client_ip]    ||= @template.request.remote_ip
        options[:js]             = 0

        options[:pay_type]       = 't' if Opay.config.test_mode
        options[:ts]             = Time.now.to_i.to_s
        options[:sig]            = Providers::Payu.create_form_sig(options)

        fields = options.map { |key, val| @template.hidden_field_tag(key, val) }.join("\n")
        js = "<script type=\"text/javascript\">document.forms['payu_payment_form_#{object.id}'].js.value = 1;</script>"

        "#{fields}\n#{js}".html_safe
      end

    end

  end
end
