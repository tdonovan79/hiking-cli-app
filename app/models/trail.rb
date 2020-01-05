# name - name of trail (string)
# length - length of trail in miles (integer)
#trail_type - type of trail (string)
#summary - description of trail(string)
#difficulty - difficulty of trail(string)
#rating - out of 5 stars (float)
#longitude - (float)
#latitude - (float)
class Trail < ActiveRecord::Base
    has_many :hikes
    belongs_to :location

    #print info of trail
    def print_info
        puts "Name: #{self.name}"
        puts "Length: #{self.length} miles"
        puts "Location: #{self.location.town}, #{self.location.state}"
        puts "Type: #{self.trail_type}"
        puts "Summary: #{self.summary}"
        puts "Difficulty: #{self.difficulty}"
        puts "Rating: #{self.rating}"
        puts "Trailhead: lat - #{self.latitude} long - #{self.longitude}"
    end
end