# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :opay_payment, :class => 'Payment' do
    item nil
    session "MyString"
    amount 1.5
    finished false
  end
end
