guard 'spork', cucumber: false, test_unit: false, rspec: true do
  watch('config/application.rb')
  watch('config/environment.rb')
  watch(%r{^config/environments/.+.rb$})
  watch(%r{^config/initializers/.+.rb$})
  watch('spec/spec_helper.rb')
end

guard 'rspec', cli: '--color --drb', all_on_start: false, all_after_pass: false do
  watch(%r{^spec/.+_spec.rb$})
  watch(%r{^app/(.+).rb$})                           { |m| "spec/#{m[1]}_spec.rb" }
  watch(%r{^lib/(.+).rb$})                           { |m| "spec/lib/#{m[1]}_spec.rb" }
  watch(%r{^spec/factories/(.+).rb$})                { "spec" }
  watch(%r{^spec/models/.+.rb$})                     { "spec/models" }
  watch(%r{^spec/routing/.+.rb$})                    { "spec/routing" }

  watch('spec/spec_helper.rb')                        { "spec" }
  watch('config/routes.rb')                           { "spec/routing" }
  watch('app/controllers/application_controller.rb')  { "spec/controllers" }
end
