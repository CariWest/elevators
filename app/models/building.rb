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
end
