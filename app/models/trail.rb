# name - name of trail (string)
# length - length of trail in miles (integer)
#type - type of trail (string)
#summary - description of trail(string)
#difficulty - difficulty of trail(string)
#rating - out of 5 stars (integer)
#longitude - (float)
#lattitude - (float)
class Trail < ActiveRecord::Base
    has_many :hikes
    belongs_to :location
end