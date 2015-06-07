# Elevators

An elevator system which manages the elevators in a high rise.

## Elevator Logic

In a high rise, there might be any number of elevators. To efficiently serve the occupants of the building, unoccupied elevators are evenly spaced out along the floors of the building.

Elevator calls are assigned to the elevator best placed to answer that call according to three criteria that are used to compute a figure of suitability (FS) for each elevator. (1) If an elevator is moving towards a call, and the call is in the same direction, FS = (N + 2) - d, where N is one less than the number of floors in the building, and d is the distance in floors between the elevator and the passenger call. (2) If the elevator is moving towards the call, but the call is in the opposite direction, FS = (N + 1) - d.  (3) If the elevator is moving away from the point of call, FS = 1. The elevator with the highest FS for each call is sent to answer it. The search for the "nearest car" is performed continuously until each call is serviced.

When an occupant requests an elevator, the nearest suitable unoccupied elevator will respond. The nearest suitable elevator is determined by the Figure of Suitability (FS). Factors which influence the Figure of Suitability are N (one less than the number of floors) and d (the distance in floors between the elevator and the passenger).
  1. If an elevator is moving towards a call and the call is in the same direction, FS = (N + 2) - d
  2. If the elevator is moving towards the call, but the call is in the opposite direction, FS = (N + 1) - d
  3. If the elevator is moving away from the point of call, FS = 1

The elevator with the highes FS will respond. **The search for the "nearest call" is performed continuously until each call is serviced.**

When an elevator finishes delivering its occupants to the desired floor, it will then be directed by the elevator system to go to a floor where the greatest need for coverage exists.

**OR**

When an elevator is in motion, it will only be able to pick up additional passengers in the direction it is traveling. When all elevators are in motion, the next available elevator will be directed to pick up passengers. Presidence will be given to covering as many passengers as possible in a single traversal of the high rise; this means an unoccupied elevator will be sent to the passenger who is the furthest away and collect additional passengers on its trip up or down the building.

**Complexity Not Accounted For**
  - for simplification purposes, the number of passengers an elevator can hold during this simulation is infinite
