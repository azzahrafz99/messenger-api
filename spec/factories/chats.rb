FactoryBot.define do
  factory :chat do
    association :conversation
    association :sender, factory: :user

    message { Faker::Lorem.sentence }
  end
end
