require_relative '../../config/environment.rb'
require 'pry'

class TrailsPos

    #run program
    def run
        login
    end

    #initialize prompt
    def initialize
        @prompt = TTY::Prompt.new
    end

#=========================LOGIN=======================================
#get username and pass through to main menu 
#TODO: passwords and authentication
    def login
        @current_user = nil
        system 'clear'
        username = @prompt.ask("What is your username?")
        if User.all.map(&:name).include?(username)
            @current_user = User.all.find{|user_instance| user_instance.name == username}
            if password
                main_menu
            end
        else
            if @prompt.yes?("There is no user by this name. Would you like to create an account?")
                create_account
            end
        end
    end

    #enter and check password, return true if password matches user's pasword
    def password
        password = @prompt.mask("Enter password: ")
        if password == @current_user.password
            true
        else
            puts "Password is invalid."
            sleep(1)
            false
        end
    end

    #create new user account
    def create_account
        new_user = @prompt.ask("Enter username: ")
        new_password = @prompt.mask("Enter password: ")
        @current_user = User.create(name: new_user, password: new_password)
        main_menu
    end


#=========================MAIN MENU=======================================
#main menu to navigate
    def main_menu
        choice = nil
        menu = ["Start New Hike",
        "End Hike",
        "Edit Hike",
        "List All My Hikes",
        "See Trails",
        "Quit"]
        while choice != "Quit"
            sleep(0.5)
            system 'clear'
            choice = @prompt.select("What would you like to do #{@current_user.name}?", menu)
            case choice
            when "Start New Hike"
                start_hike
            when "End Hike"
            end_hike
            when "Edit Hike"
                edit_options
            when "List All My Hikes"
                list_user_hikes
            when "See Trails"
                trail_options
            end
        end
    end


#======================START/END=======================================
#log a new hike for a user
    def start_hike
        trail_name = @prompt.select("Which trail?", Trail.all.map(&:name))
        @current_user.new_hike(Trail.all.find_by(name: trail_name), Time.now)
        puts "Successfully started new hike on #{trail_name}."
        @prompt.keypress("Press any key to continue")
    end

    #allow a user to select a hike to end
    def end_hike
        menu = hike_menu_maker(@current_user.incomplete_hikes)
        #if no incomplete hikes, display error and exit function. else continue
        if menu.length > 0
            hike_to_end = @prompt.select("Which trail?", menu)
            hike_to_end.time_hiked = Time.now - hike_to_end.date
            hike_to_end.completed = true
            hike_to_end.save
            puts "Hike successfully ended on #{hike_to_end.trail.name}."
        else
            puts "No incomplete hikes found."
        end
        @prompt.keypress("Press any key to continue")
    end


#======================EDIT HIKES========================================

    #allow user to choose a hike and then edit it
    def edit_options
        menu = hike_menu_maker(@current_user.reload.hikes)
        system 'clear'
        if menu.length > 0
            choice = @prompt.select("Which hike would you like to edit?", menu)
            edit_hike_menu(choice)
        else
            puts "You have no saved hikes at this time."
            @prompt.keypress("Press any key to continue")
        end
    end

    #choose what you would like to edit
    #TODO add exit option
    def edit_hike_menu(hike_instance)
        menu = ["Delete", "Change Time on Trail", "Exit"]
        system 'clear'
        choice = @prompt.select("Which action would you like to take?", menu)
        case choice
        when "Delete"
            delete_hike(hike_instance)
        when "Change Time on Trail"
            change_time(hike_instance)
        end
    end

    #after warning message, delete hike
    def delete_hike(hike_instance)
        system 'clear'
        if @prompt.yes?("Are you sure you would like to delete #{hike_instance.trail.name}" + hike_instance.date.strftime(" - %m/%d/%Y") + "?")
            hike_instance.destroy
            puts "Hike has been deleted."
        else
            puts "Hike has not been deleted"
        end
        @prompt.keypress("Press any key to continue")
    end
    #get hours and minutes from user and update time on trail
    def change_time(hike_instance)
        hours = @prompt.ask("Enter time in hours: ").to_i
        minutes = @prompt.ask("Enter time in minutes: ").to_i
        hike_instance.time_hiked = (hours * 3600) + (minutes * 60)
        hike_instance.save
        puts "New time saved."
        @prompt.keypress("Press any key to continue")
    end

#======================HIKE LISTING=======================================
#prints all hikes information from an array of hikes
    def print_hike_info(hike_array)
        hike_array.each do |hike_instance|
            puts "Trail Name: #{hike_instance.trail.name}"
            puts "Trail Length: #{hike_instance.trail.length} miles"
            puts hike_instance.date.strftime("Date Hiked: %m/%d/%Y")
            puts hike_instance.time_hiked.nil? ? "Length of Time on Trail: Hike not completed" : Time.at(hike_instance.time_hiked).utc.strftime("Length of Time on Trail: %H:%M")
            puts "Status: #{hike_instance.completed? ? "completed" : "incomplete"}"
            15.times {print "*"}
            print "\n"
        end
    end

#lists all hikes for a user
    def list_user_hikes
        if @current_user.reload.hikes.length > 0
            print_hike_info(@current_user.reload.hikes)
        else
            puts "There are no hikes to display."
        end
        @prompt.keypress("Press any key to continue")
    end

#======================TRAIL LISTING/SEARCHING=======================================
#gives options for viewing trails
    def trail_options
        menu = ["View All Trails", 
            "Search for Trail", 
            "Exit"]
        system 'clear'
        choice = @prompt.select("Which action would you like to take?", menu)
        case choice
        when "View All Trails"
            print_trail_info(Trail.all)
        when "Search for Trail"
            search_for_trail(Trail.all)
        end
        @prompt.keypress("Press any key to continue")
    end

#prints all trail info
    def print_trail_info(trails_array)
        trails_array.each do |trail_instance|
            trail_printer(trail_instance)
        end
    end

#choose to search for trail by name or by length
    def search_for_trail(trail_array)
        menu = ["Name", "Length"]
        system 'clear'
        choice = @prompt.select("Search by name or length?", menu)
        case choice
        when "Name"
            search_trail_name(trail_array)
        when "Length"
            #search_trail_length(trail_array)
        end
    end

#search for trail by name and then print info for trail
    def search_trail_name(trail_array)
        system 'clear'
        search_name = @prompt.ask("Enter name: ")
        search_trail = trail_array.find_by(name: search_name)
        if search_trail.nil?
            puts "No trail found by that name."
        else
            trail_printer(search_trail)
        end
    end



#======================MISC HELPERS=======================================
#takes in array of hikes, outputs infor in structure for menu choices
    def hike_menu_maker(hike_array)
        hike_array.map do |hike_instance|
            [hike_instance.trail.name + hike_instance.date.strftime(" - %m/%d/%Y - %H:%M"), hike_instance]
        end.to_h
    end
#take in argument of trail and displays info in easy to read format
    def trail_printer(trail_instance)
        puts "Trail Name: #{trail_instance.name}"
        puts "Trail Length: #{trail_instance.length} miles"
        15.times {print "*"}
        print "\n"
    end
end#end of TRAILSPOS class