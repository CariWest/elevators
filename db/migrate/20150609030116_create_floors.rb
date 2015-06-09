class CreateFloors < ActiveRecord::Migration
  def change
    create_table :floors do |t|
      t.references  :building
      t.integer     :approaching_elevator_id
      t.boolean     :waiting_passengers, default: false

      t.timestamps null: false
    end
  end
end
