class Bullet extends GameObject { //how to make disappear when draw new room?

  Bullet() {
    loc = new PVector(myHero.loc.x, myHero.loc.y);
    vel = new PVector(0, 0);
    vel.setMag(5);
    hp = 1;
    size = 5;
    c = white;
    roomX = myHero.roomX;
    roomY = myHero.roomY;
    damage = 5;
  }

  Bullet(PVector aim, color cb, int bsize, float bspeed) {
    loc = new PVector(myHero.loc.x, myHero.loc.y);
    vel = aim;
    vel.setMag(bspeed);
    hp = 1;
    size = bsize;
    c = cb;
    roomX = myHero.roomX;
    roomY = myHero.roomY;
    damage = int(bspeed+myHero.damage);
  }

  void show() {
    stroke(c);
    fill(c);
    ellipse(loc.x, loc.y, size, size);
  }

  void act() { //if touches wall, deleted from list
    loc.add(vel);
    if (loc.x < width*0.1 || loc.x > width*0.9 || loc.y < height*0.1 || loc.y > height*0.9) {
      hp = 0;
      createParticles();
    }
    if (roomX != myHero.roomX && roomY != myHero.roomY) {
      hp = 0;
    }
  }
  
  void createParticles() {
    int num = 50;
    int n = 0;
    while (n < num) {
      myObjects.add(new Particles(int(random(0, size)), loc.x, loc.y, c, roomX, roomY));
      n++;
    }
  }
  
}
