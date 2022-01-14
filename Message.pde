class Message extends GameObject {
  int t;
  
  Message(int rx, int ry, float locx, float locy, int _xp) {
    roomX = rx;                    //so it acts and shows
    roomY = ry;                    //so it acts and shows
    loc = new PVector(locx, locy); //spawns at enemy death spot
    vel = new PVector(0, -2);      //going up
    c = white;                     //colour
    xp = _xp;
    t = 255;
  }

  void show() {
    textSize(30);
    fill(c, t);                          //so it fades
    text("+" + xp + "XP", loc.x, loc.y); //im taking the xp from enemy and putting into text
  }

  void act() {
    super.act();
    
    t -= 5;
    if (t <= 0) hp = 0;
    if (roomX != myHero.roomX && roomY != myHero.roomY) {
      hp = 0;
    }
  }
}
