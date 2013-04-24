[![Build Status](https://travis-ci.org/olownia/opay.png)](https://travis-ci.org/olownia/opay)

# Opay

Opay is a payu.pl payment provider for Rails apps.

## Installation

Add this to your Gemfile:

``` ruby
gem 'opay'
```

and run `bundle install`.

Next, run:

``` bash
# add an initializer to config/initializers with all of the configuration options
$ rails g opay:install
# This will add the necessary migrations to your app's db/migrate directory
rake opay:install:migrations
# This will run any pending migrations
rake db:migrate
``` 
then add the following to your routes.rb file:

``` ruby
# config/routes.rb
mount Opay::Engine => '/opay'
```