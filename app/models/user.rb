class User < ActiveRecord::Base
    has_many :hikes

    #create new hike
    def new_hike(trail_instance, date, time_hiked)
        Hike.create(user: self, trail: trail_instance, date: date, time_hiked: time_hiked)
    end
    #completes hike and updates length of time hike took from start to end
    def end_hike(hike_instance)
        hike_instance.time_hiked = Time.now - hike_instance.date
        hike_instance.save
    end
    #returns array of all hikes user has taken
    def all_hikes
        Hike.all.select{|hike_instance| hike_instance.user == self}
    end
    #returns array of all hikes user has not completed
    def incomplete_hikes
        all_hikes.select{|hike_instance| hike_instance.time_hiked == 0}
    end
    #returns array of all hikes user has completed
    def complete_hikes
        all_hikes.select{|hike_instance| hike_instance.time_hiked != 0}
    end
    
end