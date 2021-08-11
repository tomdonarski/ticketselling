5.times do
  e = Event.create!(name: Faker::FunnyName.four_word_name, time: Faker::Time.forward)
  Ticket.create!(event: e, available: 25, reserved:0, sold: 0, price: Faker::Number.decimal(l_digits: 2, r_digits: 2))
  e = Event.create!(name: Faker::FunnyName.four_word_name, time: Faker::Time.forward)
  Ticket.create!(event: e, available: 26, reserved:0, sold: 0, price: Faker::Number.decimal(l_digits: 2, r_digits: 2), even: true)
  e = Event.create!(name: Faker::FunnyName.four_word_name, time: Faker::Time.forward)
  Ticket.create!(event: e, available: 25, reserved:0, sold: 0, price: Faker::Number.decimal(l_digits: 2, r_digits: 2), avoid_one: true)
  e = Event.create!(name: Faker::FunnyName.four_word_name, time: Faker::Time.forward)
  Ticket.create!(event: e, available: 26, reserved:0, sold: 0, price: Faker::Number.decimal(l_digits: 2, r_digits: 2), even: true, avoid_one: true)
end
