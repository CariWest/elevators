require 'rails_helper'

describe Building do
  let!(:building) { FactoryGirl.create(:building) }

  it "should initialize with the correct number of floors" do
    expect(building.floors).to eq 10
  end

  context "distributing elevators amongst a building" do

    let!(:elevator_1) { FactoryGirl.create(:elevator, building_id: building.id) }
    let!(:elevator_2) { FactoryGirl.create(:elevator, building_id: building.id) }

    before(:each) do
      # building.assign_elevators_to_floors
    end

    it "should distribute elevators evenly amongst a building to maximize coverage" do
      building.assign_elevators_to_floors

      expect(elevator_1.reload.floor).to eq 2
      expect(elevator_2.reload.floor).to eq 7
    end
  end
end
