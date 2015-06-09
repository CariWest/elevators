class AddFloorNumberToFloors < ActiveRecord::Migration
  def change
    add_column :floors, :floor_num, :integer
  end
end
