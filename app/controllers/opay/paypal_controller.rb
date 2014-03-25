require_dependency 'opay/application_controller'

module Opay
  class PaypalController < ApplicationController
    def new
      unless Opay.config.process_payments_localy
        redirect_to Providers::Paypal.create_payment(params[:session_id], params[:desc], params[:client_ip])
      end
    end

    def create
      if Providers::Paypal.confirm_payment(params[:token], params[:PayerID], request.remote_ip)
        redirect_to main_app.root_path, notice: I18n.t('opay.payment.success')
      end
      # render text: Providers::Payu.process(params[:pos_id], params[:session_id], params[:ts], params[:sig]) ? 'OK' : ''
    end
  end
end
