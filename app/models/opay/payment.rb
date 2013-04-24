module Opay
  class Payment < ActiveRecord::Base
    belongs_to :payable, polymorphic: true
    attr_accessible :provider, :amount, :finished, :session_id
    validates :payable, :provider, :amount, :session_id, presence: true
  end
end
