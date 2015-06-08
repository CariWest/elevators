class Elevator < ActiveRecord::Base
  belongs_to :building

  def move_to(new_floor)
    self.floor = new_floor
    self.save!
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
