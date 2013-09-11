require 'net/http'
require 'uri'

module Opay
  module Providers

    class Payu
      PAYU_URL = 'https://www.platnosci.pl/paygw/UTF'

      def self.process(pos_id, session_id, ts, sig)
        return false unless verify_sig(sig, pos_id, session_id, ts)

        ts = Time.now.to_i.to_s

        params = {
          'pos_id'     => pos_id,
          'session_id' => session_id,
          'ts'         => ts,
          'sig'        => create_sig(pos_id, session_id, ts)
        }

        connection = Net::HTTP.new('www.platnosci.pl', 443)
        connection.use_ssl = true

        response = connection.start do |http|
          post = Net::HTTP::Post.new(url(:get_payment_info))
          post.set_form_data(params)
          http.request(post)
        end

        info = Hash.from_xml(response.body)

        return false if info['response']['status'] == 'ERROR'

        pos_id     = info['response']['trans']['pos_id']
        session_id = info['response']['trans']['session_id']
        order_id   = info['response']['trans']['order_id']
        status     = info['response']['trans']['status']
        amount     = info['response']['trans']['amount']
        desc       = info['response']['trans']['desc']
        ts         = info['response']['trans']['ts']
        sig        = info['response']['trans']['sig']

        return false unless verify_sig(sig, pos_id, session_id, order_id, status, amount, desc, ts)

        if status.to_i == 99
          payment = Opay::Payment.where(session_id: session_id).first!
          payment.payable.finish

          return true
        end

        return false
      end

      def self.url(action)
        payu_url = Opay.config.process_payments_localy == true ? '/opay/payu/paygw/UTF' : PAYU_URL

        case action
        when :new_payment
          "#{payu_url}/NewPayment"
        when :get_payment_info
          "#{payu_url}/Payment/get/xml"
        end
      end

      def self.create_sig(*values)
        Digest::MD5.hexdigest(values.join + Opay.config.key1)
      end

      def self.verify_sig(sig, *values)
        sig == Digest::MD5.hexdigest(values.join + Opay.config.key2)
      end

      def self.create_form_sig(options)
        sig_string = ''
        %w( pos_id pay_type session_id pos_auth_key amount desc desc2 trsDesc order_id first_name last_name payback_login street street_hn street_an city post_code country email phone language client_ip ts ).each do |key|
          sig_string += options[key.to_sym].to_s if options.has_key?(key.to_sym)
        end

        create_sig(sig_string)
      end
    end

  end
end
