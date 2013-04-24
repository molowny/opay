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

    def payment_session_id
      raise 'Resource must be saved before payment' if id.nil?
      Digest::MD5.hexdigest(self.class.name + id.to_s)
    end

    module ClassMethods
    end

  end
end
