require 'spec_helper'

module Opay
  describe Providers::Paypal do
    context 'md5 signs' do

      before do
        @login = Opay.config.paypal_login
        @password = Opay.config.paypal_password
        @signature = Opay.config.paypal_signature
        Opay.config.process_payments_localy = false
      end

      it 'can work in test mode' do
        Opay.config.test_mode = true

        @order = Order.create! name: 'first order', amount: 1000 # 10 zł
        @order.prepare_payment

        Opay.config.paypal_login = 'ollownia-facilitator_api1.gmail.com'
        Opay.config.paypal_password = '1395743145'
        Opay.config.paypal_signature = 'AGUkzh-MeQY9FWOCQ5.UwnNAI5EgABkxUU7ynmHt9IbLYXd5FwKiwy6K'

        stub_request(:post, 'https://api-3t.sandbox.paypal.com/2.0/')
          .to_return(status: 200, body: response_from_template('paypal/payment_created.xml', {}))

        Providers::Paypal.create_payment(@order.payment.session_id, 'Description', '127.0.0.1', '/confirm', '/cancel')
        ::ActiveMerchant::Billing::Base.mode.should be :test
      end

      # it 'creates payment' do
      #   pos_id     = '123456'
      #   session_id = '0cde9e950d99630410661b2dedbbd822'
      #   ts         = '1234567890'
      #   sig        = Digest::MD5.hexdigest(pos_id + session_id + ts + @key1)

      #   # valid sig
      #   subject.class_eval { create_sig(pos_id, session_id, ts) }.should eq sig

      #   # invalid sig
      #   subject.class_eval { create_sig('23456', session_id, ts) }.should_not eq sig
      # end

    end
  end
end
