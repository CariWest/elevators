require 'rails_helper'

describe Building do
  let!(:building) { FactoryGirl.create(:building) }

  it "should initialize with the correct number of floors" do
    expect(building.floors).to eq 10
  end
end
