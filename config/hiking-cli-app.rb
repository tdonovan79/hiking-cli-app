require_relative 'environment.rb'

class TrailsPos

    #run program
    def run
        User.create(name: "Tom")
        login
    end

#=========================LOGIN=======================================

    #get user's name and check to make sure it is in database. if it is,
    #set it to username variable
    def login
        prompt = TTY::Prompt.new
        user = nil
        unless User.all.map(&:name).include?(user)
            username = prompt.ask("What is your username?")
            if username == "kill" 
                exit
            elsif User.all.map(&:name).include?(username)
                puts "This is not in the system. Please try again."
            else
                user = User.all.find{|user| user.name == username}
                puts "#{user.name}"
            end
        end
        User.all[0].destroy
        #main_menu(user)
    end


end