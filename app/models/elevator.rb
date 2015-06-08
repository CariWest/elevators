class Elevator < ActiveRecord::Base
  belongs_to :building

  def move_to(new_floor)
    self.floor = new_floor
    self.save!
  end

end
