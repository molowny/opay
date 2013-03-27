require 'opay/engine'
require 'opay/configuration'

module Opay
  extend ActiveSupport::Autoload

  include Opay::Configuration

  autoload :FormBuilder
  autoload :Helpers
  autoload :Providers
  autoload :Payable

end
