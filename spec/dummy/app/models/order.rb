class Order < ActiveRecord::Base
  include Opay::Payable

  after_payment do
    update_attribute(:finished, true)
  end
end
