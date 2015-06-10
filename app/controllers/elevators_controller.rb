class ElevatorsController < ApplicationController

  def nearest
    # expects params: { floor: [current_floor], direction: [direction]}, where floor is an integer and direction is either "up" or "down"

    Elevator.nearest({
      floor: params[:floor],
      direction: params[:direction]
    })
  end

end
