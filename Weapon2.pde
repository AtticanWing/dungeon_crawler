class Shotgun extends Weapon {
  Shotgun() {
    super(100, 5, 10, terra);
  }
  
  void shoot() {
    if (shotTimer >= reload && myHero.ammo > 0) {
      for (int i = 0; i < 10; i++) {
        PVector aimVector = new PVector(mouseX-myHero.loc.x, mouseY-myHero.loc.y);
        aimVector.rotate(random(-PI/12, PI/12));
        aimVector.setMag(bulletSpeed);
        myObjects.add(new Bullet(aimVector, terra, 10, 10));
        myHero.ammo -= 1;
      }
      shotTimer = 0;
    }
  }
}
