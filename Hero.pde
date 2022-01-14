class Hero extends GameObject {
  Weapon myWeapon;
  AnimatedGIF currentAct;
  boolean right;
  int transparency_counter;
  int healthTimer;
  int ammo;
  int reload;

  Hero() {
    super();
    loc = new PVector (width/2, height/2-18);
    speed = 6;
    size = 50;
    hp = 100;
    hpMax = hp;
    roomX = 1;
    roomY = 1;
    myWeapon = new Hose();
    immuneTimer = 0;
    threshold = 60;
    currentAct = heroIdle;
    transparency_counter = 255;
    healthTimer = 0;
    xp = 20;
    ammo = 1000;
    damage = 0;
    reload = 0;
    currentGun = hose;
    //lightRad = ;
  }

  void show() {
    pushMatrix();
    imageMode(CENTER);
    //fill(navyblue);
    //stroke(turquoise);
    //strokeWeight(2);
    //circle(loc.x, loc.y, size);
    if (immuneTimer < threshold) {
      tint(255, 180, 180);
    } else if (healthTimer < threshold/3) {
      tint(180, 255, 180);
    } else {
      tint(255, 255, 255);
    }
    currentAct.show(loc.x, loc.y, size, size);
    tint(255, 255, 255);
    drawHealthBar();

    popMatrix();
  }

  //void drawHealth() {
  //  rectMode(CORNER);
  //  noStroke();
  //}

  void drawHealthBar() {
    rectMode(CORNER);
    noStroke();
    fill(0, transparency_counter);
    rect(loc.x - 15, loc.y - (size/2+13), 30, 6);

    fill(#FF717C, transparency_counter);
    rect(loc.x - 14, loc.y - (size/2+12), 28, 4);

    fill(#7CFF70, transparency_counter);
    float lifemeter = map (hp, 0, hpMax, 0, 28);
    rect(loc.x - 14, loc.y - (size/2+12), lifemeter, 4);
  }

  void act() {
    super.act();

    immuneTimer++;
    healthTimer++;

    if (ammo < 50) {
      reload++;
      if (reload >= 30) {
        ammo++;
        reload = 0;
      }
    }
    if (ammo <= 0) {
      ammo = 0;
    }

    if (loc.y > height*0.87) loc.y = height*0.87;

    if (w) {
      vel.y = -speed;
      right = true;
      currentAct = heroRight;
    }
    if (a) {
      vel.x = -speed;
      right = false;
      currentAct = heroLeft;
    }
    if (s) {
      vel.y = speed;
      right = false;
      currentAct = heroLeft;
    }
    if (d) {
      vel.x = speed;
      right = true;
      currentAct = heroRight;
    }
    if (!w && !a && !s && !d) {
      if (right) currentAct = heroIdle;
      else currentAct = heroIdleLeft;
    }

    if (vel.mag() > speed) vel.setMag(speed);

    if (!w && !s) vel.y *= 0.75;
    if (!a && !d) vel.x *= 0.75;

    //check exits
    //North room
    if (nRoom != #FFFFFF && loc.y == height*0.1 && loc.x >= width/2 - 33 && loc.x <= width/2 + 33) {
      roomY--;
      loc = new PVector(width/2, height*0.87-10);
    }
    if (eRoom != #FFFFFF && loc.x == width*0.9 && loc.y >= height/2-33 && loc.y <= height/2+33) {
      roomX++;
      loc = new PVector(width*0.1+10, height/2);
    }
    if (sRoom != #FFFFFF && loc.y == height*0.87 && loc.x >= width/2 - 33 && loc.x <= width/2 + 33) {
      roomY++;
      loc = new PVector(width/2, height*0.1+10);
    }
    if (wRoom != #FFFFFF && loc.x == width*0.1 && loc.y >= height/2 - 33 && loc.y <= height/2 + 33) {
      roomX--;
      loc = new PVector(width*0.9-10, height/2);
    }

    myWeapon.update();
    if (space) myWeapon.shoot();

    //collision w/ enemy
    int i = 0;
    while (i < myObjects.size()) {
      GameObject obj = myObjects.get(i);
      if (obj instanceof Enemy && isCollidingWith(obj) && immuneTimer >= threshold) {
        hp -= ((Enemy) obj).damage;
        immuneTimer = 0;
        //((Bullet) obj).createParticles();
      }
      if (obj instanceof EnemyBullet && isCollidingWith(obj) && immuneTimer >= threshold) {
        hp -= ((EnemyBullet) obj).damage;
        obj.hp = 0;
        immuneTimer = 0;
        ((EnemyBullet) obj).createParticles();
      }
      if (obj instanceof DroppedItem && isCollidingWith(obj)) {
        DroppedItem item = (DroppedItem) obj;
        if (item.type == GUN) {
          myWeapon = item.w;
          item.hp = 0;
          if (item.n == 0) {
            currentGun = shotgun;
          } else if (item.n == 1) {
            currentGun = sniper;
          } else if (item.n == 2) {
            currentGun = pistol;
          } else {
            currentGun = hose;
          }
        }
        if (item.type == HEALTH && healthTimer > threshold/3) {
          hp = hp + 10;
          item.hp = 0;
          if (hp > hpMax) {
            hp = hpMax;
          }
          healthTimer = 0;
        }
        if (item.type == AMMO) {
          ammo += 10;
          item.hp = 0;
        }
      }
      i++;
    }
  }
}
