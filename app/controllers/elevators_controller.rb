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
  end

end
