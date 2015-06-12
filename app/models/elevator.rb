class Elevator < ActiveRecord::Base
  belongs_to  :building
  belongs_to  :floor
  has_many    :queued_floors, foreign_key: :approaching_elevator_id, class_name: "Floor"

  def figure_of_suitability(floor_called, called_direction)
    @floor_count = building.floors.count
    @floor_num_called = floor_called.floor_num

    if self.direction == "stationary"
      stationary_fs
    elsif same_direction_and_in_path?(called_direction)
      moving_same_direction_fs
    elsif opp_direction_and_in_path?(called_direction)
      moving_opp_direction_fs
    else
      moving_away_fs
    end
  end

  private

  # for calls which are in the path of the elevator and heading
  # in the same direction
  def same_direction_and_in_path?(called_direction)
    if called_direction == direction
      if direction == "down" && @floor_num_called < current_floor
        return true
      elsif direction == "up" && @floor_num_called > current_floor
        return true
      end
    end

    false
  end

  # for calls which are in the path of the elevator but heading
  # in the opposite direction
  def opp_direction_and_in_path?(called_direction)
    if called_direction != direction
      if direction == "down" && @floor_num_called < current_floor
        return true
      elsif direction == "up" && @floor_num_called > current_floor
        return true
      end
    end

    false
  end

  # HELPER METHODS: for calculating the Figure of Suitability and
  # determining the direction in which an elevator should move
  def stationary_fs
    @floor_count - distance
  end

  def moving_same_direction_fs
    (@floor_count + 2) - distance
  end

  def moving_opp_direction_fs
    (@floor_count + 1) - distance
  end

  def moving_away_fs
    1gi
  end

  def distance
    (current_floor - @floor_num_called).abs
  end

  def current_floor
    floor.floor_num
  end
end
