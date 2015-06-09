class ChangeFloorToFloorIdForElevators < ActiveRecord::Migration
  def change
    rename_column :elevators, :floor, :floor_id
  end
end
