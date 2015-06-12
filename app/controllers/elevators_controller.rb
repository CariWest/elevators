class ElevatorsController < ApplicationController

  def nearest
    # expects params: { floor: [current_floor], direction: [direction]}, where floor is an integer and direction is either "up" or "down"

    # stubbed for complexity
    building = Building.first

    floor_called = building.floors.find_by(floor_num: params[:floor].to_i)
    direction = params[:direction]

    elevator = building.call_elevator(floor_called, direction)
    render json: nearest_elevator_json_object(elevator, floor_called, direction)

  end

  private

  def nearest_elevator_json_object(elevator, floor_called, direction)
    figure_of_suitability = elevator.figure_of_suitability(floor_called, direction)

    {
      floor_called:     floor_called.floor_num,
      direction_called: direction,
      elevator: {
        construct_elevator_json_object(elevator)
      }
    }
  end

  def construct_elevator_json_object(elevator)
    {
      id:                     elevator.id,
      origin_floor:           elevator.floor.floor_num,
      moving_direction:       elevator.direction,
      figure_of_suitability:  figure_of_suitability,
      queued_floors:          elevator.queued_floors.sort_by { |floor| floor.floor_num }.map { |floor| construct_floor_json_object(floor) }
    }
  end

  def construct_floor_json_object(floor)
    {
      id:                 floor.id,
      floor_num:          floor.floor_num,
      waiting_passengers: floor.waiting_passengers
    }
  end

end
