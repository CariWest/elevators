require 'rails_helper'

# For the purposes of these tests, N is the number of floors a building has,
# and d is the distance between the elevator and the floor from where the call
# originates

describe Elevator do

  let!(:building) { FactoryGirl.create(:building) }

  before(:each) do
    10.times { |x| building.floors.create(building: building, floor_num: (x + 1)) }
  end

  let!(:elevator) { building.elevators.create(direction: "stationary", floor: building.floors.first) }
  let!(:floor_7) { Floor.find_by(floor_num: 7) }

  it "should initialize as stationary" do
    expect(elevator.direction).to eq "stationary"
    expect(elevator.building).to eq building
  end

  context "determining Figure of Suitability (FS)" do
    context "is called while stationary" do
      it "should have an FS equal to N - d" do
        expect(elevator.figure_of_suitability(floor_7, "down")).to eq 4
      end
    end

    context "is moving toward the call" do

      it "should have an FS equal to N + 2 - d when the call is moving in the same direction" do
        elevator.direction = "up"
        expect(elevator.figure_of_suitability(floor_7, "up")).to eq 6
      end

      it "should have an FS equal to N + 1 - d when the call is moving in the opposite direction" do
        elevator.direction = "up"
        expect(elevator.figure_of_suitability(floor_7, "down")).to eq 5
      end
    end

    context "the elevator is moving away from the call" do
      it "should have an FS equal to 1" do
        elevator.floor = Floor.find_by(floor_num: 5)
        elevator.direction = "down"

        expect(elevator.figure_of_suitability(floor_7, "down")).to eq 1
        expect(elevator.figure_of_suitability(floor_7, "up")).to eq 1
      end
    end
  end

end
