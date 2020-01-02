require 'open-uri'
require 'net/http'
require 'json'

DatabaseCleaner.clean_with(:truncation)

#50 users
50.times do
    User.create(name: Faker::Name.first_name, password: "1234")
end

#======================================================================

#get data from api
50.times do
    trail_data = {"success"=>0, "message"=>"No ids specified"}
    while trail_data == {"success"=>0, "message"=>"No ids specified"}
        url = "https://www.hikingproject.com/data/get-trails-by-id?ids=#{rand(7000000..7099999)}&key=200660943-8025210e60af686bac469d5828f5ac98"
        uri = URI.parse(url)
        response = Net::HTTP.get_response(uri)
        trail_data = JSON.parse(response.body)
    end
    #binding.pry
    trail_data = trail_data["trails"][0]

    town_state = trail_data["location"].split(", ")
    Location.create(town: town_state[0], state: town_state[1])
    Trail.create(name: trail_data["name"], length: trail_data["length"], trail_type: trail_data["type"], summary: trail_data["summary"], difficulty: trail_data["difficulty"], rating: trail_data["stars"], longitude: trail_data["longitude"], latitude: trail_data["latitude"], location: Location.all[0])
end

#=====================================================================

#50 hikes
150.times do
    Hike.create(user: User.all.sample, trail: Trail.all.sample, date: Time.now - rand(43200), time_hiked: rand(1800..18000), completed: ([true, false].sample))
end












# #50 trails
# 50.times do
#     Trail.create(name: Faker::Lorem.word, length: (rand(0.1..20.1)* 10).floor / 10.0)
# end
