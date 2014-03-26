[![Build Status](https://travis-ci.org/olownia/opay.png)](https://travis-ci.org/olownia/opay)

# Opay

Opay is a payment solution for Rails apps.

Currently supported engines:
* payu
* paypal express payment

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
get 'success' => 'controller#success', as: :success_payment
get 'cancel' => 'controller#cancel', as: :cancel_payment

mount Opay::Engine => '/opay'
```

declare which of your models recive payments

``` ruby
class ModelName < ActiveRecord::Base
  include Opay::Payable

  after_payment do
    # optional after payment callback
  end

  def amount
    100
  def
end
```

create payment form

``` haml
= opay_form_for(@model_name, provider: :payu) do |f|
  = f.payment_info first_name: 'Jan', last_name: 'Kowalski', email: 'kowalski@gmail.com', desc: 'Payment description'
  = f.submit 'pay with payu'
```

``` haml
= opay_form_for(@model_name, provider: :paypal) do |f|
  = f.payment_info desc: 'Test payment', client_ip: '127.0.0.1'
  = f.submit 'pay with payu'
```

set up online url in payu.pl to: `/opay/payu/online`
