require_dependency 'opay/application_controller'

module Opay
  class PaypalController < ApplicationController
    def new
      unless Opay.config.process_payments_localy
        redirect_to Providers::Paypal.create_payment(
          params[:session_id],
          params[:desc],
          params[:client_ip],
          params[:confirm_url],
          params[:cancel_url],
        )
      end
    end

    def confirm
      if Providers::Paypal.process(params[:token], params[:PayerID], request.remote_ip)
        redirect_to main_app.root_path, notice: I18n.t('opay.payment.success')
      end
    end
  end
end
