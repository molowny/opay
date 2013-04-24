require 'net/http'
require 'uri'

module Opay
  module Providers

    class Payu
      URL = 'https://www.platnosci.pl/paygw/UTF'

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
        case action
        when :new_payment
          "#{URL}/NewPayment"
        when :get_payment_info
          "#{URL}/Payment/get/xml"
        end
      end

      def self.create_sig(*values)
        Digest::MD5.hexdigest(values.join + Opay.config.key1)
      end

      def self.verify_sig(sig, *values)
        sig == Digest::MD5.hexdigest(values.join + Opay.config.key2)
      end
    end

  end
end
