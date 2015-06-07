require 'rails_helper'

describe Elevator do

  let!(:building) { FactoryGirl.create(:building) }
  let!(:elevator) { FactoryGirl.create(:elevator, building_id: building.id) }

  it "should initialize on floor 0 with a direction of up" do
    expect(elevator.floor).to eq 0
    expect(elevator.direction).to eq "up"
    expect(elevator.building). to eq building
  end

end
