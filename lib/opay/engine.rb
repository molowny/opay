module Opay
  class Engine < ::Rails::Engine
    isolate_namespace Opay

    config.generators do |g|
      g.test_framework :rspec, fixture: true
      g.fixture_replacement :factory_girl, dir: 'spec/factories'

      g.view_specs false
      g.helper_specs false

      g.stylesheets = false
      g.javascripts = false
    end

    initializer 'opay.initialize' do
      ActiveSupport.on_load(:action_view) do
        include Opay::Helpers::FormHelper
        include Opay::Helpers::PayuHelper
      end
    end

  end
end
