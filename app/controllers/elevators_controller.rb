class ElevatorsController < ApplicationController

  def nearest
    # expects params: { floor: [current_floor], direction: [direction]}, where floor is an integer and direction is either "up" or "down"

    # stubbed for complexity
    @building = Building.first

    floor_called = params[:floor]
    direction = params[:direction]

    elevator = @building.find_elevator({
      floor: floor,
      direction: direction
    })

    figure_of_suitability = elevator.figure_of_suitability(floor_called, direction)

    render json: {
      floor_called:           floor_called,
      direction_called:       direction,
      elevator:               elevator,
      elevator_floor:         elevator.floor.floor_num,
      elevator_direction:     elevator.direction,
      figure_of_suitability:  elevator.figure_of_suitability
    }
  end

end
