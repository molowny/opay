module Opay
  module Helpers

    module PayuHelper

      def payu_form_for(record, options = {}, &block)
        options[:builder] ||= Opay::FormBuilder

        options[:url]  = Opay::Providers::Payu.url(:new_payment)
        options[:html] = { id: "payu_payment_form_#{record.id}", class: 'payu_payment_form' }

        record.create_payment!(session_id: record.payment_session_id, provider: 'payu', amount: record.amount) if record.payment.blank?

        form_for(record, options, &block)
      end

      def payment_info(options = {})
        options[:first_name]   ||= object.first_name
        options[:last_name]    ||= object.last_name
        options[:email]        ||= object.email

        options[:pos_id]       ||= Opay.config.pos_id
        options[:pos_auth_key] ||= Opay.config.pos_auth_key
        options[:session_id]   ||= object.payment_session_id

        options[:amount]       ||= object.amount
        options[:desc]         ||= object.payment_description
        options[:client_ip]    ||= @template.request.remote_ip
        options[:js]             = 0
        options[:ts]             = Time.now.to_i.to_s

        options[:pay_type] = 't' if Opay.config.test_mode

        sig_string = ''
        %w( pos_id pay_type session_id pos_auth_key amount desc desc2 trsDesc order_id first_name last_name  payback_login street street_hn street_an city  post_code country email phone language  client_ip ts ).each do |key|
          sig_string += options[key.to_sym].to_s if options.has_key?(key.to_sym)
        end

        options[:sig] = Providers::Payu.create_sig(sig_string)


        fields = options.map { |key, val| @template.hidden_field_tag(key, val) }.join("\n")
        js = "<script type=\"text/javascript\"><!-- document.forms['payu_payment_form_#{object.id}'].js.value = 1; --></script>"

        "#{fields}\n#{js}".html_safe
      end

    end

  end
end
