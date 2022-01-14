class Particles extends GameObject {

  int t; //transparency
  color colour;
  int size;
  int r, g, b;
  boolean ifRGB;

  Particles(int s, float x, float y, color c, int rx, int ry) {
    hp = 1;
    size = s;
    colour = c;
    t = int(random(180, 255));
    loc = new PVector (x, y);
    vel = new PVector (0, 1);
    vel.rotate(random(-PI, PI)); //180 degrees
    vel.setMag(random(-2, 2));
    roomX = rx;
    roomY = ry;
    ifRGB = false;
    //println("" + roomX + roomY);
  }
  
  Particles(int s, float x, float y, int red, int green, int blue, boolean rbg) {
    hp = 1;
    size = s;
    r = red;
    g = green;
    b = blue;
    ifRGB = rbg;
    t = int(random(180, 255));
    loc = new PVector (x, y);
    vel = new PVector (0, 1);
    vel.rotate(random(-PI, PI)); //180 degrees
    vel.setMag(random(-2, 2));
    
    roomX = myHero.roomX;
    roomY = myHero.roomY;
    
    //println("yes");
  }

  void show() {
    //rectMode(CENTER);
    if (ifRGB) {
      stroke(r+30, g+30, b+30, t);
      fill(r, g, b, t);
    } else {
      stroke(colour, t);
      noFill();
    }
    circle(loc.x, loc.y, size);
  }

  void act() {
    super.act();

    t -= 10;
    if (t <= 0) hp = 0;
    if (ifRGB == false && roomX != myHero.roomX && roomY != myHero.roomY) {
      hp = 0;
    }
  }
}
