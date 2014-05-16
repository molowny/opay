require 'activemerchant'

module Opay
  module Providers

    class Paypal
      def self.create_payment(session_id, description, ip, confirm_url, cancel_url)
        # for future items list
        payment = Opay::Payment.where(session_id: session_id).first!

        response = geteway.setup_purchase(payment.amount.to_i,
          ip: ip,
          return_url: confirm_url,
          cancel_return_url: cancel_url,
          order_id: session_id,
          currency: Opay.config.paypal_currency,
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

      def self.process(token, payer_id, ip)
        payment = Opay::Payment.where(session_id: token).first!

        if Opay.config.process_payments_localy
          payment.payable.finish
          return true
        end

        response = geteway.purchase(payment.amount, {
          ip: ip,
          token: token,
          currency: Opay.config.paypal_currency,
          payer_id: payer_id
        })

        if response.success?
          payment.payable.finish
          return true
        else
          # Rails.logger.error(response.inspect)
        end

        false
      end

      private

      def self.geteway
        # ActiveMerchant::Billing::BogusGateway.new in test
        @geteway ||= begin
          ::ActiveMerchant::Billing::Base.mode = :test if Opay.config.test_mode == true

          geteway = ::ActiveMerchant::Billing::PaypalExpressGateway.new({
            login: Opay.config.paypal_login,
            password: Opay.config.paypal_password,
            signature: Opay.config.paypal_signature
          })
        end
      end
    end

  end
end
