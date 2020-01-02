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
end