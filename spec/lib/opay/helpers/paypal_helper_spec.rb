require 'spec_helper'

module Opay
  describe Helpers::PaypalHelper, type: :helper do

    context 'form tag' do
      before do
        @order = Order.create! name: 'first order', amount: 2000 # 20 zł
        Opay.config.process_payments_localy = false
      end

      it 'creates form tag' do
        html = helper.opay_form_for(@order, provider: :paypal) do |f|
          f.payment_info first_name: 'Jan', last_name: 'Kowalski', email: 'kowalski@gmail.com', desc: 'Test payment', client_ip: '127.0.0.1'
        end

        html.should have_css('form[action="/opay/paypal/new"]')
      end
    end

  end
end
