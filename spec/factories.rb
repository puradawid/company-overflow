FactoryGirl.define do
  factory :company, class: Company do
    email "example_company@gmail.com"
    password "password"
  end
end
