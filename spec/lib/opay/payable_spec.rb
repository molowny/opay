require 'spec_helper'

module Opay
  describe Payable do
    subject { Order.new }

    it { should have_one(:payment) }
    it { should respond_to(:finished?) }
  end
end
