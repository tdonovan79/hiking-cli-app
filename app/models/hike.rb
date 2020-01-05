# date - start time of hike (datetime)
# time_hiked - how long hike took(integer, measured in seconds)
# completed - whether or not hike has been ended yet(boolean)
class Hike < ActiveRecord::Base
    belongs_to :trail
    belongs_to :user
    #end hike that's not completed
    def end_hike
        self.time_hiked = Time.now - self.date
        self.completed = true
        self.save
    end

    #print info of hike
    def print_info
        puts "Trail Name: #{self.trail.name}"
        puts "Trail Length: #{self.trail.length} miles"
        puts self.date.strftime("Date Hiked: %m/%d/%Y")
        puts self.time_hiked.nil? ? "Length of Time on Trail: Hike not completed" : Time.at(self.time_hiked).utc.strftime("Length of Time on Trail: %H:%M")
        puts "Status: #{self.completed? ? "completed" : "incomplete"}"
    end
end