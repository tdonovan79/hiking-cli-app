# date - start time of hike (datetime)
# time_hiked - how long hike took(integer, measured in seconds)
# completed - whether or not hike has been ended yet(boolean)
class Hike < ActiveRecord::Base
    belongs_to :trail
    belongs_to :user

    def end_hike
        self.time_hiked = Time.now - self.date
        self.completed = true
        self.save
    end
end