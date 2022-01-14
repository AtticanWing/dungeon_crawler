class Weapon {
  
  int shotTimer;
  float reload;
  int bulletSpeed; //speed  of projectile
  int bulletSize;
  color c;
  
  Weapon() {
    shotTimer = 0;
    reload = 30;
    bulletSpeed = 5;
  }
  
  Weapon(float t, int bs, int s, color col) {
    shotTimer = 0;
    reload = t;
    bulletSpeed = bs;
    bulletSize = s;
    c = col;
  }
  
  void update() {
    shotTimer++;
  }
  
  void shoot() {
    if (shotTimer >= reload && myHero.ammo > 0) {
      PVector aimVector = new PVector(mouseX-myHero.loc.x, mouseY-myHero.loc.y);
      aimVector.setMag(bulletSpeed);
      myObjects.add(new Bullet(aimVector, c, bulletSize, bulletSpeed));
      shotTimer = 0;
      myHero.ammo -= 1;
    }
  }
}
