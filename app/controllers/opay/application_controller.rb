module Opay
  class ApplicationController < ActionController::Base
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
