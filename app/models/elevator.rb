class Elevator < ActiveRecord::Base
  belongs_to  :building
  belongs_to  :floor
  has_many    :queued_floors, foreign_key: :approaching_elevator_id, class_name: "Floor"

  def move_to(new_floor)
    set_moving_direction
    self.update_attributes(floor: new_floor)
  end

  def figure_of_suitability(floor_called, direction)
    @floor_count = building.floors.count
    @floor_num_called = floor_called.floor_num

    if self.direction == "stationary"
      stationary
    elsif same_direction_and_in_path?(direction)
      moving_same_direction
    elsif opp_direction_and_in_path?(direction)
      moving_opp_direction
    else
      moving_away
    end
  end

  def same_direction_and_in_path?(direction)
    if direction == self.direction
      if direction == "down" && @floor_num_called < current_floor
        return true
      elsif direction == "up" && @floor_num_called > current_floor
        return true
      end
    end

    false
  end

  def opp_direction_and_in_path?(direction)
    if direction != self.direction
      if self.direction == "down" && @floor_num_called < current_floor
        return true
      elsif self.direction == "up" && @floor_num_called > current_floor
        return true
      end
    end

    false
  end

  def stationary
    @floor_count - distance
  end

  def moving_same_direction
    (@floor_count + 2) - distance
  end

  def moving_opp_direction
    (@floor_count + 1) - distance
  end

  def moving_away
    1
  end

  def distance
    (current_floor - @floor_num_called).abs
  end

  def set_moving_direction
    direction = (@floor_num_called - current_floor) >= 0 ? "up" : "down"
  end

  def current_floor
    floor.floor_num
  end
end
