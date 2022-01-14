class DroppedItem extends GameObject {
  int type;
  int n;
  Weapon w;

  DroppedItem(float x, float y, int rx, int ry, int drop) {
    type = drop;
    if (type == GUN) {
      n = int(random(0, 4));
      if (n == 0) {
        w = new Shotgun();
      } else if (n == 1) {
        w = new SniperRifle();
      } else if (n == 2) {
        w = new AutoPistol();
      } else {
        w = new Hose();
      }
    }
    hp = 1;
    loc = new PVector(x, y);
    vel = new PVector(0, 0);
    size = 20;
    roomX = rx;
    roomY = ry;
    c = white;
  }

  void show() {
    if (type == GUN) {
      if (n == 0) {
        image(shotgun, loc.x, loc.y, size*4, size*2);
      } else if (n == 1) {
        image(sniper, loc.x, loc.y, size*4, size*2);
      } else if (n == 2) {
        image(pistol, loc.x, loc.y, size*4, size*2);
      } else {
        image(hose, loc.x, loc.y, size*4, size*2);
      }
    } else if (type == HEALTH) {
      image(hpPotion, loc.x, loc.y, size*2, size*2);
    } else if (type == AMMO) {
      image(ammo, loc.x, loc.y, size*3, size*3.5);
    }
  }
}
