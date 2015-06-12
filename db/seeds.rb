# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


building = Building.create

10.times do |x|
  building.floors.create(building: building, floor_num: x + 1, waiting_passengers: true)
end

2.times do
  building.elevators.create(building: building, direction: "stationary")
end

building.assign_elevators_to_floors