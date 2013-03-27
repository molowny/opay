module Opay
  module Payable
    extend ActiveSupport::Concern

    included do
      has_one :payment, as: :payable, class_name: 'Opay::Payment'
    end

    def finished?
      payment.finished?
    end

    module ClassMethods
    end

  end
end
