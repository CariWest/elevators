class Elevator < ActiveRecord::Base
  belongs_to :building

  def move_to(new_floor)
    self.floor = new_floor
    self.save!
  end

  def figure_of_suitability(floor_called, direction)
    @building_floors = building.floors
    @floor_called = floor_called

    if self.direction == "stationary"
      fs = stationary
    elsif same_direction_suitable?(direction)
      fs = same_direction_moving
    elsif opp_direction_suitable?(direction)
      fs = opp_direction_moving
    else
      fs = moving_away
    end
  end

  def same_direction_suitable?(direction)
    if direction == self.direction
      if direction == "down" && @floor_called < self.floor
        return true
      elsif direction == "up" && @floor_called > self.floor
        return true
      end
    end

    false
  end

  def opp_direction_suitable?(direction)
    if direction != self.direction
      if self.direction == "down" && @floor_called < self.floor
        return true
      elsif self.direction == "up" && @floor_called > self.floor
        return true
      end
    end

    false
  end

  def stationary
    @building_floors - distance
  end

  def moving_same_direction
    (@building_floors + 2) - distance
  end

  def moving_opp_direction
    (@building_floors + 1) - distance
  end

  def moving_away
    1
  end

  def distance
    (self.floor - @floor_called).abs
  end
end
