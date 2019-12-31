DatabaseCleaner.clean_with(:truncation)

#50 users
50.times do
    User.create(name: Faker::Name.first_name, password: "1234")
end

#50 trails
50.times do
    Trail.create(name: Faker::Lorem.word, length: (rand(0.1..20.1)* 10).floor / 10.0)
end

#50 hikes
150.times do
    Hike.create(user: User.all.sample, trail: Trail.all.sample, date: Time.now - rand(43200), time_hiked: rand(1800..18000), completed: ([true, false].sample))
end