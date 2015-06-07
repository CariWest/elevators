# Elevators

An elevator system which manages the elevators in a high rise.

## Elevator Logic

In a high rise, there might be any number of elevators. To efficiently serve the occupants of the building, unoccupied elevators are evenly spaced out along the floors of the building.

When an occupant requests an elevator, the nearest unoccupied elevator will respond. When an elevator finishes delivering its occupants to the desired floor, it will then be directed by the elevator system to go to a floor where the greatest need for coverage exists.

When an elevator is in motion, it will only be able to pick up additional passengers in the direction it is traveling. When all elevators are in motion, the next available elevator will be directed to pick up passengers. Presidence will be given to covering as many passengers as possible in a single traversal of the high rise; this means an unoccupied elevator will be sent to the passenger who is the furthest away and collect additional passengers on its trip up or down the building.