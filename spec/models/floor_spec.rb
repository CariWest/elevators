require 'rails_helper'

describe Floor do
  context "associations" do
    it { should belong_to :building }
    it { should have_many :elevators }
    it { should belong_to :approaching_elevator }
  end
end
