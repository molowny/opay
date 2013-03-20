$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "opay/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "opay"
  s.version     = Opay::VERSION
  s.authors     = ["Mariusz Ołownia"]
  s.email       = ["ollownia@gmail.com"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of Opay."
  s.description = "TODO: Description of Opay."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency 'rails', '~> 3.2.13'
  # s.add_dependency "jquery-rails"

  s.add_development_dependency 'sqlite3'
  s.add_development_dependency 'rspec-rails'
  s.add_development_dependency 'capybara'
  s.add_development_dependency 'factory_girl_rails'
  s.add_development_dependency 'database_cleaner'

  s.test_files = Dir["spec/**/*"]
end
