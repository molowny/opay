require_dependency 'opay/application_controller'

module Opay
  class PayuController < ApplicationController
    def online
      render text: 'OK'
    end
  end
end
