class Target {
  /*Initialize variables for position, speed, and easing (Note: All targets have the same behavior)
  */
  float xpos = random(100,600);
  float ypos = random(100,600);
  float xspeed = random(3,7);
  float yspeed = random(3,7);
  float easing = 0.02;
    
  /*Draw the target and constrain the easing value.
  */
  void makeTarget() {
    easing = constrain(easing, 0, 0.04);
    stroke(255,255,255);
    strokeWeight(10);
    fill(random(130,200), 50, random(180, 255));
    ellipse(xpos, ypos, 100, 100);
    strokeWeight(1);
  }
  /*Some calculations to update the target's position every frame. Basically find the difference in position
    between the target and the player, and shorten the distance by a small amount based on the easing value.
  */
  void moveTarget() {
    float targetX = p.getXpos();
    float targetY = p.getYpos();
    float dx = targetX - xpos;
    float dy = targetY - ypos;
  
    xpos += dx*easing;
    ypos += dy*easing;
  }
}