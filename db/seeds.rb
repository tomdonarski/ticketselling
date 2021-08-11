10.times do
  e = Event.create!(name: Faker::FunnyName.four_word_name, time: Faker::Time.forward)
  20.times do
    Ticket.create!(event: e, price: Faker::Number.decimal(l_digits: 2, r_digits: 2), status: 'available')
  end
end
