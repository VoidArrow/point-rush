class Power {
  /*Initialize variables for position and if the player is powered or not.
  */
  boolean powered = false;
  float xpos = random(100, 2500);
  float ypos = random(100, 1400);
  
  /*Set a random position for the powerup at the start of the game.
  */
  void genPower() {
    stroke(0,0,0);
    strokeWeight(20);
    fill(200,200,0);
    rect(xpos, ypos, 50, 50);
  }
    
}