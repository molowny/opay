module Opay
  class FormBuilder < ActionView::Helpers::FormBuilder
    include Opay::Helpers::FormHelper
    include Opay::Helpers::PayuHelper
    include Opay::Helpers::PaypalHelper
    include Opay::Helpers::TransferujHelper
  end
end
