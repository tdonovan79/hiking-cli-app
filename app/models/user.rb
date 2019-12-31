#name - name of user (string)
class User < ActiveRecord::Base
    has_many :hikes
    has_many :trails, through: :hikes

    #create new hike
    def new_hike(trail_instance, date)
        Hike.create(user: self, trail: trail_instance, date: date, time_hiked: nil, completed: false)
    end
    #returns array of all hikes user has not completed
    def incomplete_hikes
        self.hikes.select{|hike_instance| hike_instance.completed == false}
    end
    #returns array of all hikes user has completed
    def complete_hikes
        self.hikes.select{|hike_instance| hike_instance.completed == true}
    end
    
end