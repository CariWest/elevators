class Floor < ActiveRecord::Base
  belongs_to  :building
  has_many    :elevators
  belongs_to  :approaching_elevator, class_name: "Elevator"
end
