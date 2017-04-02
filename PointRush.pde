import processing.sound.*;

/*Declare necessary variables, including SoundFile, PFont (text font), Player, Targets, Power, and time, score, multiplier, and powertime variables
  Declare an array of boolean values to keep track of what keys are pressed
*/
SoundFile file;
PFont pixel;
Player p = new Player();
Target target = new Target();
Target target2 = new Target();
Target target3 = new Target();
Target target4 = new Target();
Power power = new Power();
boolean[] keys = {false, false, false, false};
float time = 0;
float score = 0;
float multiplier = 0;
float powerTime = 15;

/*Initialize font and soundfile, play soundfile, and set the size of the window.
*/
void setup() {
  pixel = createFont("pixeltype.ttf", 48);
  size(2560, 1440);
  file = new SoundFile(this, "escape.mp3");
  file.play();
}
/*Everything happens in this draw() method. Set framerate, background color, and display all of the important text.
  Draw any other geometry constantly in the background. Call the setDiff() method, generate the powerup, and generate and update the 4 targets.
  Update position of player and crosshair.  Increase time alive every frame, and double player's speed if they picked up a powerup.
  If the crosshair is touching a target, reset the target's position to a random spawnpoint and add 10*multiplier to the player's score.
  If the target touches the player, set p.dead to true and restrict all movement.
  Note: the draw methods for the powerup, player, and targets MUST be called every frame.
*/
void draw() {
  frameRate(100);
  background(100,100,120);
  stroke(120, 120, 120);
  fill(180, 120, 120);
  textFont(pixel);
  textSize(48);
  text("Score: " + String.format("%.2f", score), 100, 100);
  text("Time: " + String.format("%.2f", time), 100, 150);
  text("Use WASD to move. Move the cursor to hit targets before they hit you.", 50, 1330);
  text("Use Z and X to change difficulty.", 50, 1380);
  textSize(36);
  text("Music: Escape (Thomas Was Alone) - David Housden", 50, 1430);
  textSize(48);
  stroke(120,120,120);
  fill(120, 120, 180);
  rect(100, 200, 500, 500);
  rect(1960, 1240, 500, -500);
  
  setDiff();
  power.genPower();
  target.makeTarget();
  target.moveTarget();
  target2.makeTarget();
  target2.moveTarget();
  target3.makeTarget();
  target3.moveTarget();
  target4.makeTarget();
  target4.moveTarget();
  p.crosshair();
  p.makePlayer();
  
  if (p.dead == false) {
    time += 0.01;
  }
  if (power.powered == true && powerTime >= 0 && p.dead == false) {
    fill(150,150,220);
    text("Power: 2x Speed", 1100, 100);
    text(String.format("%.2f", powerTime), 1230, 150);
    powerTime -= 0.01; 
    p.xspeed = 30;
    p.yspeed = -30;
    power.xpos = 0;
    power.ypos = -100;
  }
  else {
    p.xspeed = 15;
    p.yspeed = -15;
    power.powered = false;
  }
  
  if (abs(mouseX - target.xpos) < 50 && abs(mouseY - target.ypos) < 50 && p.dead == false) {
    target.xpos = random(100,600);
    target.ypos = random(200,700);
    score += 10*multiplier;
  }
  if (abs(mouseX - target2.xpos) < 50 && abs(mouseY - target2.ypos) < 50 && p.dead == false) {
    target2.xpos = random(100,600);
    target2.ypos = random(200,700);
    score += 10*multiplier;
  }
  if (abs(mouseX - target3.xpos) < 50 && abs(mouseY - target3.ypos) < 50 && p.dead == false) {
    target3.xpos = random(1960,2460);
    target3.ypos = random(740,1240);
    score += 10*multiplier;
  }
  if (abs(mouseX - target4.xpos) < 50 && abs(mouseY - target4.ypos) < 50 && p.dead == false) {
    target4.xpos = random(1960, 2460);
    target4.ypos = random(740, 1240);
    score += 10*multiplier;
  }
  
  if ((abs(p.xpos - target.xpos) < 50 && abs(p.ypos - target.ypos) < 50)
  || (abs(p.xpos - target2.xpos) < 50 && abs(p.ypos - target2.ypos) < 50)
  || (abs(p.xpos - target3.xpos) < 50 && abs(p.ypos - target3.ypos) < 50)
  || (abs(p.xpos - target4.xpos) < 50 && abs(p.ypos - target4.ypos) < 50)) {
    p.death();
    target.easing = 0;
    target2.easing = 0;
    target3.easing = 0;
    target4.easing = 0;
  }

  if (abs(p.xpos - power.xpos) < 50 && abs(p.ypos - power.ypos) < 50) {
    power.powered = true;
  }

  if (keys[0]) {
    p.moveLeft();
  }
  else if (keys[1]) {
    p.moveRight();
  } 
  else if (keys[2]) {
    p.moveUp();
  }
  else if (keys[3]) {
    p.moveDown();
  }  
}

/*Both keyPressed() and keyReleased() keep track of keys pressed, including difficulty-changing keys and restart key
*/
public void keyPressed() {
  if (key == 'a') {
    keys[0] = true;
  }
  else if (key == 'd') {
    keys[1] = true;
  }
  else if (key == 'w') {
    keys[2] = true;
  }
  else if (key == 's') {
    keys[3] = true;
  }
  else if (key == 'x') {
    target.easing += 0.01;
    target2.easing += 0.01;
    target3.easing += 0.01;
    target4.easing += 0.01;
  }
  else if (key == 'z') {
    target.easing -= 0.01;
    target2.easing -= 0.01;
    target3.easing -= 0.01;
    target4.easing -= 0.01;
  }
  else if (key == 'r' && p.dead == true) {
    restart(); 
  }
}

public void keyReleased() {
  if (key == 'a') {
    keys[0] = false;
  }
  else if (key == 'd') {
    keys[1] = false;
  }
  else if (key == 'w') {
    keys[2] = false;
  }
  else if (key == 's') {
    keys[3] = false; 
  }
}

/*Keep track of the current difficulty. If the targets easing value (how fast it approaches the player) changes,
  update the difficulty text and the multiplier accordingly.
*/
public void setDiff() {
 if (target.easing == 0.00) {
    multiplier = 0;
    fill(180,120,120);
    text("Difficulty: Practice", 1950, 100);
    text("Score Multiplier:" + multiplier + "x", 1950, 150);
  }
  else if (target.easing == 0.01) {
    multiplier = 0.5;
    fill(180,120,120);
    text("Difficulty: Easy", 1950, 100);
    text("Score Multiplier:" + multiplier + "x", 1950, 150);
  }
  else if (target.easing == 0.02) {
    multiplier = 1;
    fill(180,120,120);
    text("Difficulty: Normal", 1950, 100);
    text("Score Multiplier:" + multiplier + "x", 1950, 150);
  }
  else if (target.easing == 0.03) {
    multiplier = 1.5;
    fill(180,120,120);
    text("Difficulty: Hard", 1950, 100);
    text("Score Multiplier:" + multiplier + "x", 1950, 150);
  }
  else if (target.easing == 0.04) {
    multiplier = 2.0;
    fill(180,120,120);
    text("Difficulty: Very Hard", 1950, 100);
    text("Score Multiplier:" + multiplier + "x", 1950, 150);
  }  
}

/*Handles all events that occur upon restart. Reset player's and targets' positions, targets' easing values, time, score,
  multiplier, set p.dead to false, and restart the music.
*/
public void restart() {
    score = 0;
    time = 0;
    multiplier = 1;
    p.xpos = 1280;
    p.ypos = 720;
    target.xpos = random(100,600);
    target.ypos = random(200,700);
    target2.xpos = random(100,600);
    target2.ypos = random(200,700);
    target3.xpos = random(1960,2460);
    target3.ypos = random(740,1240);
    target4.xpos = random(1960, 2460);
    target4.ypos = random(740, 1240);
    p.dead = false;
    file.play();
    target.easing = 0.02;
    target2.easing = 0.02;
    target3.easing = 0.02;
    target4.easing = 0.02;
  }