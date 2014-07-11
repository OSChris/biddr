FactoryGirl.define do 
  factory :user do 
    sequence(:email)      { |n| "some_name_#{n}@gmail.com" }
    password              "somevalidpassword123"
    password_confirmation "somevalidpassword123"
  end

end
