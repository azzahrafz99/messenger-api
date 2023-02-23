FactoryBot.define do
  factory :conversation do
    association :recipient, factory: :user
    association :sender, factory: :user
  end
end
