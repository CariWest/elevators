class Floor < ActiveRecord::Base
  belongs_to :building
  belongs_to :approaching_elevators, class_name: "Elevator"

  before_save :assign_floor_num

  def assign_floor_num
    floor_num = self.building.floors.count + 1
  end
end
