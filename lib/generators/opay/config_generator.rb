module Opay
  module Generators
    class ConfigGenerator < Rails::Generators::Base
      source_root File.expand_path(File.join(File.dirname(__FILE__), 'templates'))

      desc "Description: Copies Opay configuration file to your application's initializer directory"
      def copy_config_file
        template 'opay_config.rb', 'config/initializers/opay_config.rb'
      end
    end
  end
end