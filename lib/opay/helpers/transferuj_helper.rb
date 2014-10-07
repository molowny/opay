module Opay
  module Helpers

    module TransferujHelper

      def transferuj_form_for(record, options = {}, &block)
        record.prepare_payment

        options[:builder] ||= Opay::FormBuilder
        options[:url]  = Opay::Providers::Transferuj.url
        options[:html] = { id: "transferuj_payment_form_#{record.id}", class: 'opay-form opay-transferuj-form' }

        form_for(record, options, &block)
      end

      def transferuj_payment_info(options = {})
        options[:id]           ||= Opay.config.transferuj_user_id
        options[:crc]          ||= object.payment_session_id

        options[:kwota]        ||= object.amount
        options[:opis]         ||= options[:desc].present? ? options[:desc] : object.payment_description

        options[:imie]         ||= options[:first_name].present? ? options[:first_name] : object.first_name
        options[:nazwisko]     ||= options[:last_name].present? ? options[:last_name] : object.last_name
        options[:email]        ||= object.email

        options[:pow_url]      ||= @template.main_app.send(Opay.config.success_url)
        options[:pow_url_blad] ||= @template.main_app.send(Opay.config.cancel_url)

        # options[:pay_type]       = 't' if Opay.config.test_mode
        options[:md5sum]         = Providers::Transferuj.create_form_sig(options)

        options.except(:first_name, :last_name, :desc).map { |key, val| @template.hidden_field_tag(key, val) }.join("\n").html_safe
      end

    end

  end
end
