FactoryBot.define do
  factory :reward do
    id {1}
    user_id {1}
    title {"test"}
    point {"1"}
    sort {"0"}
    
    trait :invalid do
      user_id {nil}
      title {nil}
    end
  end

  factory :reward_changed ,class: Reward do
    id {1}
    user_id {1}
    title {"changed"}
    point {"2"}
    sort {"0"}
    
    trait :invalid do
      user_id {nil}
      title {nil}
    end
  end
end
