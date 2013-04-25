module Opay
  module Payable
    extend ActiveSupport::Concern
    extend ActiveModel::Callbacks

    included do
      has_one :payment, as: :payable, class_name: 'Opay::Payment'
      define_model_callbacks :payment, only: :after
    end

    def finished?
      payment.present? && payment.finished?
    end

    def finish
      run_callbacks :payment do
        payment.update_attribute(:finished, true)
      end
    end

    def prepare_payment
      if payment.blank?
        create_payment!(provider: 'payu', amount: amount)
      else
        payment.update_attribute(:session_id, Payment.generate_session_id)
        payment
      end
    end

    def payment_session_id
      raise 'Resource must be prepared before payment' if payment.blank?
      payment.session_id
    end

    module ClassMethods
    end

  end
end
