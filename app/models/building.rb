class Building < ActiveRecord::Base
  has_many :elevators
  has_many :floors

  def assign_elevators_to_floors
    floors_per_section = floors.count / elevators.count

    elevators.each_with_index do |elevator, index|
      floor_num = (index * floors_per_section) + (floors_per_section / 2)
      elevator.update_attributes(floor: Floor.find_by(floor_num: floor_num))
    end
  end

  def call_elevator(floor_called, direction)
    best_elevator = find_elevator(floor_called, direction)
    best_elevator.queued_floors << floor_called

    return best_elevator
  end

  def find_elevator(floor_called, direction)
    best_elevator = self.elevators.first
    best_fs = 0

    self.elevators.each do |elevator|
      current_fs = elevator.figure_of_suitability(floor_called, direction)
      if current_fs > best_fs
        best_fs = current_fs
        best_elevator = elevator
      end
    end

    return best_elevator
  end
end
