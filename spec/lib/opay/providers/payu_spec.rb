require 'spec_helper'

module Opay
  describe Providers::Payu do
    context 'md5 signs' do

      before do
        @key1 = Opay.config.key1
        @key2 = Opay.config.key2
      end

      it 'creates md5 sig' do
        pos_id     = '123456'
        session_id = '0cde9e950d99630410661b2dedbbd822'
        ts         = '1234567890'
        sig        = Digest::MD5.hexdigest(pos_id + session_id + ts + @key1)

        # valid sig
        subject.class_eval { create_sig(pos_id, session_id, ts) }.should eq sig

        # invalid sig
        subject.class_eval { create_sig('23456', session_id, ts) }.should_not eq sig
      end

      it 'checks md5 sig' do
        pos_id     = '123456'
        session_id = '0cdeyutyuuytt410661b2dedbbd822'
        ts         = '1234567890'
        sig        = Digest::MD5.hexdigest(pos_id + session_id + ts + @key2)

        # valid received params
        subject.class_eval { verify_sig(sig, pos_id, session_id, ts) }.should be true

        # invalid received params
        subject.class_eval { verify_sig(sig, '23456', session_id, ts) }.should be false
      end

      it 'creates md5 sig from form options' do
        order = Order.create! name: 'first order', amount: 1000 # 10 zł

        options = {}
        options[:first_name]   = 'Jan'
        options[:last_name]    = 'Kowalski'
        options[:email]        = 'kowalski@gmail.com'

        options[:pos_id]       = '122177'
        options[:pos_auth_key] = 'qKoC8JK'
        options[:session_id]   = 'a7deb9a6840e764b4dac3ce9469a788c'

        options[:amount]       = 100
        options[:desc]         = 'Test payment'
        options[:client_ip]    = '127.0.0.1'
        options[:js]           = 0
        options[:ts]           = '1366819972'

        options[:pay_type]     = 't'

        Opay.config.key1 = 'acd63ab0226ee883365718abefd6147c'

        subject.class_eval { create_form_sig(options) }.should eq 'f3ef26044eef9400342cc0b514bd3cc5'
      end

    end

    context 'online' do
      subject { Providers::Payu }

      before do
        @order = Order.create! name: 'first order', amount: 1000 # 10 zł
        @order.prepare_payment
        # @order.create_payment!(session_id: @order.payment_session_id, provider: 'payu', amount: @order.amount)
      end

      it 'valid payment' do
        payment_info = {
          pos_id: Opay.config.pos_id,
          session_id: @order.payment_session_id,
          order_id: nil,
          status: 99,
          amount: @order.amount,
          desc: 'description',
          ts: Time.now.to_i.to_s
        }

        payment_info[:sig] = Digest::MD5.hexdigest(payment_info.values.join + Opay.config.key2)

        stub_request(:post, 'https://www.platnosci.pl/paygw/UTF/Payment/get/xml')
          .to_return(status: 200, body: response_from_template('success.xml', payment_info))

        ts = Time.now.to_i.to_s
        sig =  Digest::MD5.hexdigest(Opay.config.pos_id.to_s + @order.payment_session_id + ts + Opay.config.key2)

        @order.payment.finished.should be false
        subject.process(Opay.config.pos_id, @order.payment_session_id, ts, sig).should be true
        @order.payment.reload.finished.should be true
      end

      it 'invalid payment' do
        payment_info = {
          pos_id: Opay.config.pos_id,
          session_id: @order.payment_session_id,
          order_id: nil,
          status: 99,
          amount: @order.amount,
          desc: 'description',
          ts: Time.now.to_i.to_s
        }

        payment_info[:sig] = 'invalid sig'

        stub_request(:post, 'https://www.platnosci.pl/paygw/UTF/Payment/get/xml')
          .to_return(status: 200, body: response_from_template('success.xml', payment_info))

        ts = Time.now.to_i.to_s
        sig =  Digest::MD5.hexdigest(Opay.config.pos_id.to_s + @order.payment_session_id + ts + Opay.config.key2)

        subject.process(Opay.config.pos_id, @order.payment_session_id, ts, sig).should be false
      end

      it 'error' do
        stub_request(:post, 'https://www.platnosci.pl/paygw/UTF/Payment/get/xml')
          .to_return(status: 200, body: response_from_template('error.xml'))

        ts = Time.now.to_i.to_s
        sig =  Digest::MD5.hexdigest(Opay.config.pos_id.to_s + @order.payment_session_id + ts + Opay.config.key2)

        subject.process(Opay.config.pos_id, @order.payment_session_id, ts, sig).should be false
      end

    end
  end
end
