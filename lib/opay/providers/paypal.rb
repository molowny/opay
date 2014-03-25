module Opay
  module Providers

    class Paypal
      PAYU_URL = 'https://www.platnosci.pl/paygw/UTF'

      def self.process(pos_id, session_id, ts, sig)
        return false
      end

      def self.create_payment(session_id, description, ip)
        # for future items list
        payment = Opay::Payment.where(session_id: session_id).first!

        response = geteway.setup_purchase(payment.amount.to_i,
          ip: ip,
          return_url: 'http://localhost:3000/opay/paypal/create',
          cancel_return_url: 'http://localhost:3000/?cancel',
          order_id: session_id,
          items: [{
            name: description,
            quantity: 1,
            amount: payment.amount.to_i
          }]
        )

        # check if response is success
        if response.success?
          payment.update_attribute(:session_id, response.token)
          geteway.redirect_url_for(response.token)
        end
      end

      def self.confirm_payment(token, payer_id, ip)
        payment = Opay::Payment.where(session_id: token).first!

        if Opay.config.process_payments_localy
          payment.payable.finish
          return true
        end

        response = geteway.purchase(payment.amount, {
          ip: ip,
          token: token,
          payer_id: payer_id
        })

        if response.success?
          payment.payable.finish
          return true
        end

        false
      end

      private

      def self.geteway
        # ActiveMerchant::Billing::BogusGateway.new in test
        @geteway ||= begin
          ActiveMerchant::Billing::Base.mode = :test if Opay.config.test_mode == true

          geteway = ActiveMerchant::Billing::PaypalExpressGateway.new({
            login: Opay.config.paypal_login,
            password: Opay.config.paypal_password,
            signature: Opay.config.paypal_signature
          })
        end
      end
    end

  end
end
