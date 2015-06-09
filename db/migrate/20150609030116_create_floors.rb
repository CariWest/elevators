class CreateFloors < ActiveRecord::Migration
  def change
    create_table :floors do |t|
      t.references  :building
      t.references  :elevator, default: nil
      t.boolean     :waiting_passengers, default: false

      t.timestamps null: false
    end
  end
end
