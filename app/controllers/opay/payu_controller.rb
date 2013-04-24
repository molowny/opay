require_dependency 'opay/application_controller'

module Opay
  class PayuController < ApplicationController
    def online
      render text: Providers::Payu.process(params[:pos_id], params[:session_id], params[:ts], params[:sig]) ? 'OK' : ''
    end
  end
end
