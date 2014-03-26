require 'spec_helper'

module Opay
  describe Helpers::FormHelper, type: :helper do

    context 'form tag' do
      before do
        @order = Order.create! name: 'first order', amount: 1000 # 10 zł
      end

      it 'retunts error in provider not set' do
        expect{ helper.opay_form_for(@order) }.to raise_error(ArgumentError)
        expect{ helper.opay_form_for(@order, provider: :not_existing) }.to raise_error(ArgumentError)

        expect { helper.opay_form_for(@order, provider: :payu) {} }.to_not raise_error
        expect { helper.opay_form_for(@order, provider: :paypal) {} }.to_not raise_error
      end
    end
  end
end
