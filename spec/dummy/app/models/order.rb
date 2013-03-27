class Order < ActiveRecord::Base
  include Opay::Payable
  attr_accessible :amount, :name
end
