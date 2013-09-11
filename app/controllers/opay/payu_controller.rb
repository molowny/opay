require_dependency 'opay/application_controller'

module Opay
  class PayuController < ApplicationController
    def online
      render text: Providers::Payu.process(params[:pos_id], params[:session_id], params[:ts], params[:sig]) ? 'OK' : ''
    end

    def paygw
    end

    def correct_authorization
      payment = Opay::Payment.where(session_id: params[:session_id]).first!
      payment.payable.finish
      redirect_to '/?success'
    end

    def wrong_authorizationt
      redirect_to '/?error'
    end
  end
end
