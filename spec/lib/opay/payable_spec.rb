require 'spec_helper'

module Opay
  describe Payable do
    subject { Order.new }

    it { should have_one(:payment) }
    it { should respond_to(:finished?) }

    it 'has unique session_id' do
      # unsaved record raises exception
      expect { subject.payment_session_id }.to raise_error RuntimeError

      subject.save!
      subject.payment_session_id.should eq Digest::MD5.hexdigest('Order' + subject.id.to_s)
    end
  end
end
