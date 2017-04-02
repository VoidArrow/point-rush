class Player {
  /*Initialize variables for players position and speed in both directions
  */
  float xpos = 1280;
  float ypos = 720;
  float xspeed = 15;
  float yspeed = -15;
  boolean dead = false;
  
  /*Draw the player and ensure that the player cannot leave the bounds of the window.
  */
  void makePlayer() {
    xpos = constrain(xpos, 0, width-50);
    ypos = constrain(ypos, 50, height);
    stroke(0,0,0);
    strokeWeight(10);
    fill(150,200,150);
    ellipse(xpos, ypos, 100, 100);
  }
  
  /*Draw the crosshair and laser, both of which follow the mouse and cannot leave the bounds of the window.
  */
  void crosshair() {
    stroke(240,0,0);
    strokeWeight(5);
    line(mouseX+10, mouseY, mouseX+40, mouseY);
    line(mouseX-10, mouseY, mouseX-40, mouseY);
    line(mouseX, mouseY+10, mouseX, mouseY+40);
    line(mouseX, mouseY-10, mouseX, mouseY-40);
    stroke(random(100, 255), 0, 0);
    strokeWeight(10);
    line(xpos, ypos, mouseX, mouseY);
    strokeWeight(5);
  }
  
  /*Simple updating position methods, called every frame if a key is pressed.
  */
  void moveLeft() {
    xpos -= xspeed;
  }
  
  void moveRight() {
    xpos += xspeed;
  }
  
  void moveUp() {
    ypos += yspeed;
  }
  
  void moveDown() {
    ypos -= yspeed;
  }
  
  /*Handles events that occur on death.  Stop movement, stop the music, display text to show final score and time.
  */
  void death() {
    dead = true;
    file.stop();
    stroke(0,0,0);
    fill(100,100,100);
    ellipse(xpos, ypos, 100, 100);
    fill(0,0,0);
    xspeed = 0;
    yspeed = 0;
    textSize(72);
    text("You died!", 1080, 500);
    text("Score: " + String.format("%.2f", score), 1000, 650);
    text("Time: " + String.format("%.2f", time), 1035, 800);
    text("Press [r] to restart.", 850, 1000);
    textSize(48);
  }
  
  /*Accessor methods for xpos and ypos, used in the target class.
  */
  float getXpos() {
    return xpos;
  }
   float getYpos() {
    return ypos;
  }
}