module Opay
  class FormBuilder < ActionView::Helpers::FormBuilder
    include Opay::Helpers::PayuHelper
  end
end
