FactoryBot.define do
  factory :lineitem do
  association :food
   
   food_id {4}
    
  end
end