#name - name of user (string)
class User < ActiveRecord::Base
    has_many :hikes
    has_many :trails, through: :hikes
    

    #returns array of all hikes user has not completed
    def incomplete_hikes
        self.hikes.select{|hike_instance| hike_instance.completed == false}
    end
    
    #returns array of all hikes user has completed
    def complete_hikes
        self.hikes.select{|hike_instance| hike_instance.completed == true}
    end
                
    #display stats
    def display_stats
        puts "Name: #{self.name}"
        puts "Number of hikes: #{self.reload.hikes.length}"
        puts "Number of trails hiked: #{self.reload.hikes.select(&:trail).uniq.length}"
        puts "Miles hiked: #{self.reload.hikes.map(&:trail).map(&:length).sum}"
        puts "Average Mile Per Hour: #{self.complete_hikes.map(&:trail).map(&:length).sum.to_f / 
            (self.complete_hikes.map(&:time_hiked).sum/3600).to_f}"
        TTY::Prompt.new.keypress("Press any key to continue")
    end
    
end