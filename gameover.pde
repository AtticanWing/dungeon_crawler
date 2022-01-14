void gameover() {
  PImage currIm;
  
  imageMode(CORNER);
  cursor();
  
  if (win) {
    gameover2.show();
    replay.show();
    fill(green);
    textSize(55);
    text("YOU    WIN!", 460, 120);
    stroke(green);
    strokeWeight(5);
    triangle(400, 160, 460, 170, 520, 160);
    triangle(360, 100, 460, 85, 560, 100);
    if (tactile) {
      fill(terra, 150);
    } else {
      fill(black, 100);
    }
    textSize(40);
    text("PLAY", 590, 350);
    text("AGAIN?", 590, 400);
    
  } else {
    
    gameover1.show();
    replay.show();
    fill(grey);
    textSize(70);
    text("YOU    DIED", 400, 40);
    stroke(grey);
    strokeWeight(5);
    triangle(250, 40, 240, 50, 250, 60);
    triangle(545, 40, 555, 50, 545, 60);
    circle(390,50, 5);
    fill(terra, 180);
    if (tactile) {
      currIm = pattern1;
    } else {
      currIm = pattern;
    }
    image(currIm, 0, 440, 300, 200);
    image(currIm, 490, 440, 300, 200);
    textSize(40);
    text("PLAY   AGAIN?", 400, 350);
  }

  if (replay.clicked) {
    setup();
    mode = INTRO;
  }
}
