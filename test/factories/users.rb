FactoryGirl.define do
  factory :user do
    first_name "John"
    last_name "Doe"
    email "test@chanintr.com"
    password "Secret01"
    password_confirmation {password}
  end
end
