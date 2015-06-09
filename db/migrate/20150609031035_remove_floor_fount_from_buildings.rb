class RemoveFloorFountFromBuildings < ActiveRecord::Migration
  def change
    remove_column :buildings, :floors
  end
end
