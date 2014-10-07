require 'net/http'
require 'uri'

module Opay
  module Providers

    class Transferuj
      TRANSFERUJ_URL = 'https://secure.transferuj.pl/'

      def self.process(params)
        return false unless verify_sig(params[:md5sum], params[:id], params[:tr_id], params[:tr_amount], params[:tr_crc])

        if params[:tr_status] == 'TRUE'
          payment = Opay::Payment.where(session_id: params[:tr_crc]).first!
          payment.payable.finish
        end

        return true
      end

      def self.url
        Opay.config.process_payments_localy == true ? '/opay/transferuj/secure' : TRANSFERUJ_URL
      end

      def self.create_sig(*values)
        Digest::MD5.hexdigest(values.join + Opay.config.transferuj_secure_code)
      end

      def self.verify_sig(sig, *values)
        sig == Digest::MD5.hexdigest(values.join + Opay.config.transferuj_secure_code)
      end

      def self.create_form_sig(options)
        sig_string = ''
        %w( id kwota crc ).each do |key|
          sig_string += options[key.to_sym].to_s if options.has_key?(key.to_sym)
        end

        create_sig(sig_string)
      end
    end

  end
end
