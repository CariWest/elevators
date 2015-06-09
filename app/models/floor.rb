class Floor < ActiveRecord::Base
  belongs_to :building
  belongs_to :approaching_elevators, class_name: "Elevator"
end
