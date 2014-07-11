FactoryGirl.define do 
  
  factory :bid do
    association  :auction, factory: :auction
    amount Faker::Number.number(2)
  end

end