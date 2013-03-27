module Opay
  class Payment < ActiveRecord::Base
    belongs_to :payable, polymorphic: true
    attr_accessible :amount, :finished, :session
  end
end
