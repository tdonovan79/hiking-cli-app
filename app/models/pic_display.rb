require 'colorize'
class PicDisplay
    def logo
        puts"
         _____              _  _                                    
        /__   \\ _ __  __ _ (_)| |   /\\/\\    __ _ __   __ ___  _ __  
          / /\\/| '__|/ _` || || |  /    \\  / _` |\\ \\ / // _ \\| '_ \\ 
         / /   | |  | (_| || || | / /\\/\\ \\| (_| | \\ V /|  __/| | | |
         \\/    |_|   \\__,_||_||_| \\/    \\/ \\__,_|  \\_/  \\___||_| |_|".colorize(:green)
                                                                    
        

        puts"
                        ,sdPBbs.
                      ,d$$$$$$$$b.
                     d$P'`Y'`Y'`?$b
                    d'    `  '  \\ `b".colorize(:light_cyan)
puts "                   /    |        \\  \\
                  /    / \\       |   \\
             _,--'        |      \\    |
           /' _/          \\   |        \\
        _/' /'             |   \\        `-.__
    __/'       ,-'    /    |    |     \\      `--...__
  /'          /      |    / \\     \\     `-.           `\\
 /    /;;,,__-'      /   /    \\            \\            `-.
/    |;;;;;;;\\                                             \\".colorize(:magenta)
    end

    fork { exec 'afplay', "app/hawk_screech.mp3" }



end

test = PicDisplay.new
test.logo