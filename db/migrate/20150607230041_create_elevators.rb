class CreateElevators < ActiveRecord::Migration
  def change
    create_table :elevators do |t|
      t.string      :direction
      t.integer     :floor
      t.references  :building

      t.timestamps null: false
    end
  end
end
