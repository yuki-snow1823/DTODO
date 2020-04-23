FactoryBot.define do
  factory :user do
    name {"test-user"}
    email {"test@test.jp"}
    uid {"123456"}

    trait :invalid do
      name {nil}
    end
  end
end
