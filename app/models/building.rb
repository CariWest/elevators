class Building < ActiveRecord::Base
  has_many :elevators

  # private

  def assign_elevators_to_floors
    num_floors = self.floors
    num_elevators = self.elevators.count

    num_sections = num_elevators
    floors_per_section = num_floors / num_sections

    elevators.each_with_index do |elevator, index|
      new_floor = (index * floors_per_section) + (floors_per_section / 2)
      elevator.move_to(new_floor)
    end
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

    # elevator.queue_floor(floor_called)
    return best_elevator
  end
end
