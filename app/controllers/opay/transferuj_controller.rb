require_dependency 'opay/application_controller'

module Opay
  class TransferujController < ApplicationController
    def online
      render text: Providers::Transferuj.process(params) ? 'TRUE' : ''
    end

    def secure
    end
  end
end
