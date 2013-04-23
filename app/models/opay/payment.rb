module Opay
  class Payment < ActiveRecord::Base
    belongs_to :payable, polymorphic: true
    attr_accessible :provider, :amount, :finished, :session_id
  end
end
