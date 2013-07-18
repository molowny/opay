module Opay
  class Payment < ActiveRecord::Base
    belongs_to :payable, polymorphic: true
    # attr_accessible :provider, :amount, :finished, :session_id, :status
    validates :payable, :provider, :amount, presence: true

    before_create do |p|
      p.session_id = Payment.generate_session_id
    end

    def self.generate_session_id
      # Generate a token by looping and ensuring does not already exist.
      loop do
        token = SecureRandom.base64(15).tr('+/=lIO0', 'pqrsxyz')
        break token unless Payment.where(session_id: token).first
      end
    end

  end
end
