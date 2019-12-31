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
        @current_user = nil
        username = prompt.ask("What is your username?")
        if User.all.map(&:name).include?(username)
            @current_user = User.all.find{|user_instance| user_instance.name == username}
            sleep(1)
            system 'clear'
            main_menu
        else
            if prompt.yes?("There is no user by this name. Would you like to create an account?")
                create_account
            end
        end
    end

    #create new user account
    def create_account
        prompt = TTY::Prompt.new
        new_user = prompt.ask("Enter username: ")
        @current_user = User.create(name: new_user)
        main_menu
    end


#=========================MAIN MENU=======================================
#main menu to navigate
    def main_menu
        prompt = TTY::Prompt.new
        choice = nil
        menu = ["Start New Hike",
        "End Hike",
        "Edit Hike",
        "List All My Hikes",
        "Quit"]
        while choice != "Quit"
            choice = prompt.select("What would you like to do?", menu)
            case choice
            when "Start New Hike"
                start_hike
            when "End Hike"
            end_hike
            when "Edit Hike"
                edit_choice
            when "List All My Hikes"
                print_all_hikes(@current_user.reload.hikes)
            end
        end
    end


#======================START/END=======================================
#log a new hike for a user
    def start_hike
        prompt = TTY::Prompt.new
        trail_name = prompt.select("Which trail?", Trail.all.map(&:name))
        @current_user.new_hike(Trail.all.find_by(name: trail_name), Time.now)
        puts "Successfully started new hike on #{trail_name}."
    end

    #allow a user to select a hike to end
    def end_hike
        prompt = TTY::Prompt.new
        menu = hike_menu_maker(@current_user.incomplete_hikes)
        #if no incomplete hikes, display error and exit function. else continue
        if menu.length > 0
            hike_to_end = prompt.select("Which trail?", menu)
            hike_to_end.time_hiked = Time.now - hike_to_end.date
            hike_to_end.completed = true
            hike_to_end.save
        else
            puts "No incomplete hikes found."
        end
    end


#======================EDIT HIKES========================================

    #allow user to choose a hike and then edit it
    def edit_choice
        prompt = TTY::Prompt.new
        menu = hike_menu_maker(@current_user.reload.hikes)
        if menu.length > 0
            choice = prompt.select("Which hike would you like to edit?", menu)
            edit_hike_menu(choice)
        else
            puts "You have no saved hikes at this time."
        end
    end

    #choose what you would like to edit
    #TODO add exit option
    def edit_hike_menu(hike_instance)
        prompt = TTY::Prompt.new
        menu = ["Delete", "Change Date", "Change Time on Trail"]
        choice = prompt.select("Which action would you like to take?", menu)
        case choice
        when "Delete"
            delete_hike(hike_instance)
        when "Change Date"
            change_date(hike_instance)
        when "Change Time on Trail"
            change_time(hike_instance)
        end
    end

    #after warning message, delete hike
    def delete_hike(hike_instance)
        prompt = TTY::Prompt.new
        if prompt.yes?("Are you sure you would like to delete #{hike_instance.trail.name}" + hike_instance.date.strftime(" - %m/%d/%Y") + "?")
            hike_instance.destroy
        end
    end

    #change date of hike
    def change_date(hike_instance)
        #TODO 
    end

    def change_tim(hike_instance)
        #TODO
    end

#======================HIKE LISTING=======================================
#prints all hikes information from an array of hikes
    def print_all_hikes(hike_array)
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


#======================MISC HELPERS=======================================
#takes in array of hikes, outputs infor in structure for menu choices
    def hike_menu_maker(hike_array)
        hike_array.map do |hike_instance|
            [hike_instance.trail.name + hike_instance.date.strftime(" - %m/%d/%Y"), hike_instance]
        end.to_h
    end
end#end of HIKINGPOS class