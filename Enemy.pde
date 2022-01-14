class Enemy extends GameObject {

  int bulletTimer;
  int transparency_counter = 255;
  int enemyThreshold;
  int damage;
  int corner;
  int drop;
  int hit;
  boolean gif;
  boolean idlegif;
  AnimatedGIF currentAct;
  AnimatedGIF right;
  AnimatedGIF left;
  AnimatedGIF idle;

  Enemy() {
    loc = new PVector(width/2, height/2);
    vel = new PVector(0, 0);
    hp = hpMax = 100;
    size = 50;
    c = green;
    damage = 10;
    roomX = 1;
    roomY = 1;
    bulletTimer = 0;
    enemyThreshold = 120;
    xp = 5;
    hit = 0;
    numEnemy++;
  }

  Enemy(int x, int  y) {
    loc = new PVector(width/2, height/2);
    vel = new PVector(0, 0);
    hp = hpMax = 100;
    size = 50;
    c = green;
    damage = 10;
    roomX = x;
    roomY = y;
    bulletTimer = 0;
    enemyThreshold = 120;
    xp = 5;
    numEnemy++;
  }

  Enemy(int _hp, int s, int x, int y, int locE, int d, color ecolor, int t) {
    corner = locE;
    gif = false;
    if (locE == 1) {
      loc = new PVector(width*0.1+100, height*0.1+100);
    } else if (locE == 2) {
      loc = new PVector(width*0.9-100, height*0.1+100);
    } else if (locE == 3) {
      loc = new PVector(width*0.1+100, height*0.9-100);
    } else {
      loc = new PVector(width*0.9-100, height*0.9-100);
    }
    vel = new PVector(0, 0);
    hp = hpMax = _hp;
    size = s;
    c = ecolor;
    roomX = x;
    roomY = y;
    damage = d;
    bulletTimer = 0;
    enemyThreshold = t;
    xp = 5;
    numEnemy++;
  }

  Enemy(int _hp, int s, int x, int y, int locE, int d, AnimatedGIF i, AnimatedGIF r, AnimatedGIF l, int t) {
    corner = locE;
    gif = true;
    idlegif = true;
    if (locE == 1) {
      loc = new PVector(width*0.1+100, height*0.1+100);
    } else if (locE == 2) {
      loc = new PVector(width*0.9-100, height*0.1+100);
    } else if (locE == 3) {
      loc = new PVector(width*0.1+100, height*0.9-100);
    } else {
      loc = new PVector(width*0.9-100, height*0.9-100);
    }
    vel = new PVector(0, 0);
    hp = hpMax = _hp;
    size = s;
    currentAct = idle = i;
    right = r;
    left = l;
    roomX = x;
    roomY = y;
    damage = d;
    bulletTimer = 0;
    enemyThreshold = t;
    xp = 5;
    numEnemy++;
  }

  Enemy(int _hp, int s, int x, int y, int locE, int d, AnimatedGIF r, AnimatedGIF l, int t) {
    corner = locE;
    gif = true;
    right = r;
    left = l;
    if (locE == 1) {
      loc = new PVector(width*0.1+100, height*0.1+100);
      currentAct = right;
    } else if (locE == 2) {
      loc = new PVector(width*0.9-100, height*0.1+100);
      currentAct = left;
    } else if (locE == 3) {
      loc = new PVector(width*0.1+100, height*0.9-100);
      currentAct = right;
    } else {
      loc = new PVector(width*0.9-100, height*0.9-100);
      currentAct = left;
    }
    vel = new PVector(0, 0);
    hp = hpMax = _hp;
    size = s;
    roomX = x;
    roomY = y;
    damage = d;
    bulletTimer = 0;
    enemyThreshold = t;
    xp = 5;
    numEnemy++;
    println("yes");
  }

  void show() {

    if (hit < 10) {
      tint(255, 180, 180);
    } else {
      tint(255, 255, 255);
    }
    if (gif == false) {
      stroke(black);
      strokeWeight(2);
      fill(c);
      ellipse(loc.x, loc.y, size, size);
      tint(255, 255, 255);
      stroke(#ED0505);
      strokeWeight(5);
      line(loc.x, loc.y, myHero.loc.x, myHero.loc.y);
    } else if (gif) {
      print("" + loc.x + " " + loc.y);
      currentAct.show(loc.x, loc.y, size, size);
    }
    tint(255, 255, 255);
    drawHealthBar();
  }

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
    bulletTimer++;
    hit++;

    if (gif) {
      float d = dist(myHero.loc.x, myHero.loc.y, loc.x, loc.y);
      if (d <= 200 && roomX == myHero.roomX && roomY == myHero.roomY) {
        if (loc.x <= myHero.loc.x) {
          currentAct = right;
        } else {
          currentAct = left;
        }
        vel = new PVector(myHero.loc.x - loc.x, myHero.loc.y - loc.y);
        vel.setMag(3);
      } else {
        if (idlegif) {
          currentAct = idle;
          vel = new PVector(0, 0);
        }
      }
    }


    if (bulletTimer >= enemyThreshold) {
      PVector aimVector = new PVector(myHero.loc.x - loc.x, myHero.loc.y - loc.y);
      aimVector.setMag(5);
      myObjects.add(new EnemyBullet(aimVector, black, 10, 10, loc.x, loc.y));
      bulletTimer = 0;
    }

    int i = 0;
    while (i < myObjects.size()) {
      GameObject obj = myObjects.get(i);
      if (obj instanceof Bullet && isCollidingWith(obj)) {
        hit = 0;
        hp -= ((Bullet) obj).damage;
        obj.hp = 0;
        ((Bullet) obj).createParticles();
        if (hp <= 0) {
          //count kills-------------------------------------------------------------------
          //numKills++;
          //add xp------------------------------------------------------------------------
          myHero.xp += xp;
          myObjects.add(new Message(roomX, roomY, loc.x, loc.y, xp));
          //dropped items-----------------------------------------------------------------
          int chance = int(random(0, 100));
          if (chance < 25) {
            int dropChance = int(random(1, 4)); 
            if (dropChance == 1) {
              drop = GUN;
            } else if (dropChance == 2) {
              drop = HEALTH;
            } else if (dropChance == 3) {
              drop = AMMO;
            }
            myObjects.add(new DroppedItem(loc.x, loc.y, roomX, roomY, drop));
          }
        }
      }
      i++;
    }
  }
}   
