require 'rails_helper'

# For the purposes of these tests, N is the number of floors a building has,
# and d is the distance between the elevator and the floor from where the call
# originates

describe Elevator do

  let!(:building) { FactoryGirl.create(:building) }
  let!(:elevator) { FactoryGirl.create(:elevator, building_id: building.id) }

  it "should initialize on floor 0 as stationary" do
    expect(elevator.floor).to eq 0
    expect(elevator.direction).to eq "stationary"
    expect(elevator.building). to eq building
  end

  context "elevator is called while stationary" do
    it "should have a FS equal to N - d" do
      expect(elevator.figure_of_suitability(7, "down")).to eq 3
    end
  end

  context "the elevator is moving toward the call" do

    it "should have an FS equal to N + 2 - d when the call is moving in the same direction" do
      elevator.direction = "up"
      expect(elevator.figure_of_suitability(7, "up")).to eq 5
    end

    it "should have an FS equal to N + 1 - d when the call is moving in the opposite direction" do
      elevator.direction = "up"
      expect(elevator.figure_of_suitability(7, "down")).to eq 4
    end
  end

  context "the elevator is moving away from the call" do
    it "should have an FS equal to 1" do
      elevator.floor = 5
      elevator.direction = "down"

      expect(elevator.figure_of_suitability(7, "down")).to eq 1
      expect(elevator.figure_of_suitability(7, "up")).to eq 1
    end
  end

end
