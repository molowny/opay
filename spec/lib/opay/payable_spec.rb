require 'spec_helper'

module Opay
  describe Payable do
    subject { Order.new(name: 'first order', amount: 1000) }

    describe 'associations' do
      it { should have_one(:payment) }
    end

    it { should respond_to(:finished?) }

    it 'has unique session_id' do
      # unsaved record raises exception
      expect { subject.payment_session_id }.to raise_error RuntimeError

      subject.save!
      subject.prepare_payment

      subject.payment_session_id.should be_kind_of String
    end

    it 'prepares payment' do
      # Payable must be saved before payment
      subject.save!

      # create new payment
      subject.prepare_payment.should be_kind_of Payment

      # payment has a unique session_id
      session_id = subject.payment.session_id

      # if we prepare payment saved befor
      subject.prepare_payment.should be_kind_of Payment

      # session_id must be regenerated
      subject.payment.session_id.should_not eq session_id
    end

  end
end
