# FishTales2

![fishTank](/fishTank.png)

 _Fish Tank_

 * Tail that grows and flaps along with the fish & follows the direction of movement
 * Bubbles come out of fish, then float to the top of the tank
   * Bubbles appear using the Gaussian distribution
 * The closer a Fish is to maxAge, the more likely that "Tapping the Tank" will kill it
 	 * "Tap the Tank" with key "t" and bubbles will appear at mouse position
   * Tap the tank shakes the tank and fish go in opposite directions
 * "Clean the Tank" (net to get rid of dead fish & pellets that the net collides with)
 	 * Fish movement produces ammonia - if not cleaned, fish start gradually dying after a set amount of time
 * Pellets - Food, Poison, and Slowness pellets
   * Fish follow food & poison
   * Pellets fall at random speeds
 * Reset button to completely reset the screen (and regenerate seaweed)
 * Seaweed generate at random positions and random sizes and wave in the tank (resetting the tank resets the seaweed as well)
   * Goldfish in the seaweed have a probability of not being eaten by the piranhas
 * Fish are of different genders - when a male & female of the same species meet, there is a 20% chance that a new fish of that species is born
 * Click on fish for more info (Name, Species, Gender, Age, Weight, Alive/Death & How)
   * Drag the fish
 * Keyboard (corresponding keys are written on the button; space bar to pause)

![details](/details.png)

 _Displaying details of the selected fish_
 
![clean](/clean.png)

 _Cleaning the fish tank_
