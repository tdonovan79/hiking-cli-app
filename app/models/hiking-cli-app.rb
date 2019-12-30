require_relative '../../config/environment.rb'
require 'pry'

class TrailsPos

    #run program
    def run
        login
    end

#=========================LOGIN=======================================
#get username and pass through to main menu 
#TODO: passwords and authentication
    def login
        prompt = TTY::Prompt.new
        current_user = nil
        no_id_flag = 0
        while no_id_flag == 0
            username = prompt.ask("What is your username?")
            if User.all.map(&:name).include?(username)
                no_id_flag = 1
                current_user = User.all.find{|current_user| current_user.name == username}
                sleep(1)
                system 'clear'
                main_menu(current_user)
            else
                puts "This is not in the system. Please try again."
                no_id_flag = 0
                sleep(1)
                #TODO: create new user
            end
        end
    end
end

#=========================MAIN MENU=======================================
#main menu to navigate
def main_menu(current_user)
    prompt = TTY::Prompt.new
    choice = nil
    menu = ["Start New Hike",
    "End Hike",
    "List All My Hikes",
    "Edit Hike"
    "Quit"]
    while choice != "Quit"
        choice = prompt.select("What would you like to do?", menu)
        case choice
        when "Start New Hike"
            start_hike(current_user)
        when "End Hike"
        end_hike(current_user)
        when "List All My Hikes"
            print_all_hikes(current_user.all_hikes)
        end
    end
end


#======================HIKE LOGGING/EDITING=======================================
#log a new hike for a user
def start_hike(current_user)
    prompt = TTY::Prompt.new
    trail_name = prompt.select("Which trail?", Trail.all.map(&:name))
    current_user.new_hike(Trail.all.find_by(name: trail_name), Time.now, 0)
    puts "Successfully started new hike on #{trail_name}."
end

#allow a user to select a hike to end
def end_hike(current_user)
    prompt = TTY::Prompt.new
    menu = current_user.incomplete_hikes.map do |hike_instance|
        [hike_instance.trail.name + hike_instance.date.strftime(" - %m/%d/%Y"), hike_instance]
    end.to_h
    hike_to_end = prompt.select("Which trail?", menu)
    current_user.end_hike(hike_to_end)
end




#======================HIKE LISTING=======================================
#prints all hikes information from an array of hikes
def print_all_hikes(hike_array)
    hike_array.each do |hike_instance|
        puts "Trail Name: #{hike_instance.trail.name}"
        puts "Trail Length: #{hike_instance.trail.length} miles"
        puts hike_instance.date.strftime("Date Hiked: %m/%d/%Y")
        puts "Length of Time on Trail: #{hike_instance.time_hiked}"
    end
end