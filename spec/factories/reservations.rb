# frozen_string_literal: true

FactoryBot.define do
  factory :reservation do
    ticket
    expired { false }
    paid { false }
    expires_at { DateTime.current + 5.minutes }
    ticket_count { 1 }

    trait :expired do
      expired { true }
    end
    trait :paid do
      paid { true }
    end
  end
end
