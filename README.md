# Elevators

An elevator system which manages the elevators in a high rise.

## Elevator Logic

In a high rise, there might be any number of elevators. To efficiently serve the occupants of the building, unoccupied elevators are evenly spaced out along the floors of the building.

When an occupant requests an elevator, the nearest suitable unoccupied elevator will respond. The nearest suitable elevator is determined by the Figure of Suitability (FS). Factors which influence the Figure of Suitability are N (one less than the number of floors) and d (the distance in floors between the elevator and the passenger).
  1. If an elevator is stationary, FS = N - d
  2. If an elevator is moving towards a call and the call is in the same direction, FS = (N + 2) - d
  3. If the elevator is moving towards the call, but the call is in the opposite direction, FS = (N + 1) - d
  4. If the elevator is moving away from the point of call, FS = 1

The elevator with the highes FS will respond. **The search for the "nearest call" is performed continuously until each call is serviced.**

**Reduced Complexity in this App**
  - for simplification purposes, the number of passengers an elevator can hold during this simulation is infinite
  - this app does not account for queueing the destination floor for a passenger


## Play With This Application
  1. Clone the application to your computer
  2. Run the following commands:

  ```
  bundle exec rake db:create
  bundle exec rake db:migrate
  bundle exec rake db:seed
  ```

  3. Currently, the seed file creates a building with ten floors, as well as two elevators which are initialized as stationary. To play with different figures of suitability, you can increase the floor count, change the number of elevators, and decide whether some elevators are already in motion (either "up" or "down").
  4. Run your localhost server
  5. Submit an api request to the endpoint `/elevator_system/call`. You will need to provide two params:
    * **Floor:** the floor where an elevator has been requested
    * **Direction:** the direction ("up" or "down") in which a requester wishes to travel

  **Sample Request**
  ```
  http://localhost:3000/elevator_system/call?floor=1&direction=up
  ```
  6. The api will return a json object with information about the elevator which is being sent, including its origin floor, the current moving direction, and the floor's position in the queued_floors. The returned object is formatted as follows:

  ```
  {
    "floor_called": 1,
    "direction_called": "up",
    "elevator": {
      "id": 3,
      "origin_floor": 2,
      "moving_direction": "up",
      "figure_of_suitability": 9,
      "queued_floors": [
        {
          "id": 12,
          "floor_num": 2,
          "waiting_passengers": true
        },
        {
          "id": 15,
          "floor_num": 5,
          "waiting_passengers": true
        }
      ]
    }
  }
  ```

## Next Steps

This application is a very simple API which chooses an appropriate elevator to send when an elevator call is made. At this point, the algorithm to choose an elevator and queue a floor is fleshed out. If I spend more time on this project, there are a few more features I would add to fully explore this elevator system:
  * `#move_to(floor)`: a method which starts moving an elevator towards a floor; this method will also change the moving_direction of an elevator
  * `#request(floor)`: a method which accepts a requested floor from a passenger which is on the floor and queues the floor to the elevator
    * this method would use some logic to accept queued floors. For example, an elevator which has nothing in its queue would be able to queue a floor & travel in any direction, but an elevator which has floors queued can only queue floors which are in the direction it is currently traveling
  * `#redistrubte_elevators`: when an elevator has no more floors in its queue, it is sent to a floor where its position reduces the wait time for future elevator requests. When all elevators are stationary, they are distributed evenly amongst the floors to maximize coverage and minimize wait time.
  * Full functionality of creating a complex elevator system, which includes but isn't limited to creating a building, defining the number of floors in a building, and identifying the number of elevators in the elevator system.

## Conclusion

I had a great time working on this challenge. I particularly enjoyed creating the algorithm to choose an elevator, which is a fascinating concept I haven't considered before.

I struggled most with the open-ended nature of this challenge. I had a hard time deciding how much to include in my application, especially in regards to what information is necessary for an Elevator System to work.

For example, I was unsure whether or not I should include the building and floors in this application, since that's technically outside the scope of an Elevator System. I eventually decided to keep the building and the floors in this application so that it could be fleshed out and set up as an online application; however, I believe the code is written in a modular way which would allow me to restructure quickly and easily if necessary.

I spent approximately 5.5 hours on this challenge. My time is broken down approximately as follows:
  * 1 hour: creating the figure_of_suitability algorithm (including time to research how elevators work)
  * 2 hours: structuring the application with emphasis on OO design, readability, and modularity.
  * 2 hours: testing & debugging
  * .5 hours: final debugging & adding of comments