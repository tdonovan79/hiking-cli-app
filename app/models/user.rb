class User < ActiveRecord::Base
    has_many :hikes


    def new_hike(trail, date, time_hiked)
        Hike.create(user: self, trail: trail, date: date, time_hiked: time_hiked)
    end

    def all_hikes
        Hike.all.select{|hike_instance| hike_instance.user == self}
    end
end