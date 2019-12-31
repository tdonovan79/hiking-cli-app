# date - start time of hike (datetime)
# time_hiked - how long hike took(integer, measured in seconds)
# completed - whether or not hike has been ended yet(boolean)
class Hike < ActiveRecord::Base
    belongs_to :trail
    belongs_to :user
end