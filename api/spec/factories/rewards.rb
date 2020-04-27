FactoryBot.define do
  factory :reward do
    user_id {1}
    title {"test"}
    point {"1"}
    
    trait :invalid do
      user_id {nil}
      title {nil}
    end
  end
end
