# name - name of trail (string)
# length - length of trail in miles (integer)
class Trail < ActiveRecord::Base
    has_many :hikes
end