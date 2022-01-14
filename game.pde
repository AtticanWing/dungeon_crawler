void game() {
  imageMode(CORNER);
  drawRoom();
  imageMode(CENTER);
  drawGameObjects();
  drawDarkness();
  drawMiniMap();
  drawInventory();

  image(crosshair, mouseX, mouseY, 50, 50);
  noCursor();
  println(numEnemy);

  if (p) {
    mode = PAUSE;
  }
  //if (p) {
  //  win = false;
  //  mode = GAMEOVER;
  //}
  if (numEnemy == 0) {
    win = true;
    mode = GAMEOVER;
  }
  if (myHero.hp <= 0) {
    win = false;
    mode = GAMEOVER;
  }
}

void drawRoom() {
  background(grey);

  //corners
  stroke(3);
  line(0, 0, width, height);
  line(0, height, width, 0);

  //exits
  //1. find which walls have exits
  nRoom = map.get(myHero.roomX, myHero.roomY-1);
  eRoom = map.get(myHero.roomX+1, myHero.roomY);
  sRoom = map.get(myHero.roomX, myHero.roomY+1);
  wRoom = map.get(myHero.roomX-1, myHero.roomY);

  imageMode(CORNER);
  drawFloor(); //floor

  //2. draw exit doors
  noStroke();
  fill(black);
  imageMode(CENTER);
  if (nRoom != #FFFFFF) {
    image(door, width/2, height*0.1-25, 200, 200);
  }
  if (eRoom != #FFFFFF) {
    pushMatrix();
    translate(width*0.9+25, height/2);
    rotate(radians(90));
    image(door, 0, 0, 200, 200);
    popMatrix();
  }
  if (sRoom != #FFFFFF) {
    pushMatrix();
    translate(width/2, height*0.9+25);
    rotate(radians(180));
    image(door, 0, 0, 200, 200);
    popMatrix();
  }
  if (wRoom != #FFFFFF) {
    pushMatrix();
    translate(width*0.1-25, height/2);
    rotate(radians(-90));
    image(door, 0, 0, 200, 200);
    popMatrix();
  }
}

void drawDarkness() {
  for (int i = 0; i < darkness.size(); i++) {
    DarknessCell cell  = darkness.get(i);
    cell.show();
  }
}

void drawGameObjects() {
  numEnemy = 0;
  for (int i = 0; i < myObjects.size(); i++) {
    GameObject obj  = myObjects.get(i);
    if (obj instanceof Bullet || obj instanceof EnemyBullet || obj instanceof Particles) {
      obj.act();
    }
    if (obj.roomX == myHero.roomX && obj.roomY == myHero.roomY) {
      obj.show();
      if (!(obj instanceof Bullet) && !(obj instanceof EnemyBullet) && !(obj instanceof Particles)) {
        obj.act();
      }
    } 
    if (obj.hp <= 0) {
      myObjects.remove(i);
      i--;
    }
    if (obj instanceof Enemy) {
      numEnemy++;
    }
  }
}

void drawFloor() {
  float x = width*0.1, y = height*0.1;
  float size = width*0.8/4;
  while (y < height*0.85) {
    image(tile, x, y, size, size);
    x += size;
    if (x > width*0.8) {
      x = width*0.1;
      y = y + size;
    }
  }
}

void drawMiniMap() {
  int mx = 0;
  int my = 0;
  int t = 150; //transparency
  float size = 10;
  color c = map.get(mx, my);

  while (my < map.height) {

    if (myHero.roomX*8 + 50 == 8*mx+50 && myHero.roomY*8 + 50 == 8*my+50) {
      c = turquoise;
      t = 255;
    } else {
      c = map.get(mx, my);
      t = 150;
    }
    fill(c, t);
    noStroke();
    rect((size-1)*mx+50, (size-1)*my+50, size, size);
    mx += 1;
    if (mx >= map.width) {
      mx = 0;
      my += 1;
    }
  }
}

void drawInventory() {
  textSize(50);
  text("HP : " + myHero.hp, 600, 75);
  text("AMMO : " + myHero.ammo, 600,125);
  image(currentGun, 220, 100);
}

//void drawPause() {
//  image(pausebutton, width-100, 100, 80,70);
//}
