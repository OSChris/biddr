FactoryGirl.define do 
  
  factory :auction do 
    sequence(:title)  {|n| "#{Faker::Company.bs} - #{n}"}
    details           Faker::Lorem.paragraph
    reserve           Faker::Number.number(3)
    end_date          (Time.now + 30.days)  
  end

end