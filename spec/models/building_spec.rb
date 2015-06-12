require 'rails_helper'

describe Building do
  let!(:building) { FactoryGirl.create(:building) }

  # let!(:elevator_1) { FactoryGirl.create(:elevator, building: building) }
  # let!(:elevator_2) { FactoryGirl.create(:elevator, building: building) }

  before(:each) do
    10.times { |x| building.floors.create(building: building, floor_num: (x + 1)) }
  end

  let!(:elevator_1) { building.elevators.create(building: building, direction: "stationary", floor: building.floors.first) }
  let!(:elevator_2) { building.elevators.create(building: building, direction: "stationary", floor: building.floors.first) }

  # let!(:floor_1) { Floor.find_by(floor_num: 1) }
  let!(:floor_2) { Floor.find_by(floor_num: 2) }
  let!(:floor_4) { Floor.find_by(floor_num: 4) }
  let!(:floor_6) { Floor.find_by(floor_num: 6) }
  let!(:floor_7) { Floor.find_by(floor_num: 7) }

  it "should initialize with the correct number of floors" do
    expect(building.floors.count).to eq 10
  end

  context "distributing elevators amongst a building" do
    before(:each) do
      building.assign_elevators_to_floors
    end

    it "should distribute elevators evenly amongst a building to maximize coverage" do

      expect(elevator_1.floor).to eq floor_2
      expect(elevator_2.floor).to eq floor_7
    end
  end

  context "finding the most suitable elevator" do

    before(:each) do
      building.assign_elevators_to_floors
    end

    it "should pick the elevator which is the closest when both are stationary" do
      expect(building.find_elevator(floor_4, "up")).to eq elevator_1
      expect(building.find_elevator(floor_6, "down")).to eq elevator_2
    end

    it "should pick the elevator which is moving in the same direction and hasn't passed the floor" do
      elevator_1.direction = "up"
      expect(building.find_elevator(floor_4, "up")).to eq elevator_1
    end

    it "should pick between two moving elevators" do
      elevator_1.direction = "up"
      elevator_2.direction = "down"

      expect(building.find_elevator(floor_4, "up")).to eq elevator_1
      expect(building.find_elevator(floor_6, "down")).to eq elevator_2
    end

    it "should not choose an elevator which is moving away" do
      elevator_2.direction = "up"

      expect(elevator_2.direction).to eq "up"
      expect(elevator_2.figure_of_suitability(floor_6, "down")).to eq 1

      expect(building.find_elevator(floor_6, "down")).to eq elevator_1
    end
  end
end
