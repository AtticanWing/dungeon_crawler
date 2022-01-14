class Follower extends Enemy {
  Follower(int x, int y, int rmLoc) {
    super(100, 60, x, y, rmLoc, 5, slimeRight, slimeLeft, 60);
  }

  void act() {
    super.act();

    vel = new PVector(myHero.loc.x - loc.x, myHero.loc.y - loc.y);
    vel.setMag(3);
  }
}

class Goblin extends Enemy {
  Goblin(int x, int y, int rmLoc) {
    super(100, 50, x, y, rmLoc, 5, goblinIdle, goblinRight, goblinLeft, 60);
  }

  void act() {
    super.act();
    //float d = dist(myHero.loc.x, myHero.loc.y, loc.x, loc.y);
    //if (d <= 150 && roomX == myHero.roomX && roomY == myHero.roomY) {
    //  vel = new PVector(myHero.loc.x - loc.x, myHero.loc.y - loc.y);
    //  vel.setMag(3);
    //}
  }
}

class Summoner extends Enemy {
  int summonTimer;
  int summonThreshold;
  Summoner(int x, int y, int roomLoc) {
    super(100, 70, x, y, roomLoc, 5, summonerRight, summonerLeft, 120);
    //println(roomLoc);
    summonThreshold = 200;
    summonTimer = 0;
  }

  void act() {
    super.act();
    summonTimer++;
    if (summonTimer >= summonThreshold) {
      myObjects.add(new Bat(roomX, roomY, roomLoc, loc.x, loc.y));
      //println(roomLoc);
      summonTimer = 0;
    }
    vel = new PVector(0, 0);
    if (loc.x <= myHero.loc.x) {
      currentAct = right;
    } else {
      currentAct = left;
    }

    //if (hp == 0) {
    //  for (int b = 0; b < 5; b++) {
    //    myObjects.add(new Bat(roomX, roomY, roomLoc, loc.x+random(-10,10), loc.y+random(-10,10)));
    //  }
    //}

    //????
    int i = 0;
    while (i < myObjects.size()) {
      GameObject obj = myObjects.get(i);
      if (obj instanceof Bullet) {
        float d = dist(obj.loc.x, obj.loc.y, loc.x, loc.y);
        if (d <= size/2 + obj.size/2 && roomX == myHero.roomX && roomY == myHero.roomY) {
          hp -= ((Bullet) obj).damage;
          obj.hp = 0;
          ((Bullet) obj).createParticles();
          for (int b = 0; b < 5; b++) {
            myObjects.add(new Bat(roomX, roomY, roomLoc, loc.x+random(-10, 10), loc.y+random(-10, 10)));
          }
        }
      }
      i++;
    }
  }
}

class Bat extends Enemy {

  Bat(int x, int y, int rloc, float _x, float _y) { //replace w gif once hp is 0 and play death animation, int
    super(50, 60, x, y, rloc, 1, batRight, batLeft, 180);
    loc = new PVector(_x, _y);
    xp = 1;
  }

  void act() {
    super.act();

    vel = new PVector(myHero.loc.x - loc.x, myHero.loc.y - loc.y);
    vel.setMag(3);

    int i = 0;
    while (i < myObjects.size()) {
      GameObject obj = myObjects.get(i);
      if (obj instanceof Bat) {
        float d = dist(obj.loc.x, obj.loc.y, loc.x, loc.y);
        if (d <= size/2 + obj.size/2 && roomX == myHero.roomX && roomY == myHero.roomY) {

          //deflect from each other???
          //for (int b = 0; b < 5; b++) {
          //  myObjects.add(new Bat(roomX, roomY, roomLoc, loc.x+random(-10,10), loc.y+random(-10,10)));
          //}
        }
      }
      i++;
    }
  }
}
