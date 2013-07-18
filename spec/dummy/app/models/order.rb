class Order < ActiveRecord::Base
  include Opay::Payable
  # attr_accessible :amount, :name

  # after_payment do
  # end
end
