class ElevatorsController < ApplicationController

  def nearest
    # expects params: { floor: [current_floor], direction: [direction]}, where floor is an integer and direction is either "up" or "down"

    # stubbed for complexity
    building = Building.first

    floor_called = building.floors.find_by(floor_num: params[:floor].to_i)
    direction = params[:direction]

    elevator = building.call_elevator(floor_called, direction)
    figure_of_suitability = elevator.figure_of_suitability(floor_called, direction)

    render json: {
      floor_called:           floor_called,
      direction_called:       direction,
      elevator:               elevator,
      elevator_floor:         elevator.floor.floor_num,
      elevator_direction:     elevator.direction,
      figure_of_suitability:  figure_of_suitability
    }
  end

  end

end
