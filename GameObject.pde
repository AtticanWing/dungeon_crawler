class GameObject {
  PVector loc; //location
  PVector vel; //velocity
  int hp, hpMax;
  color c;
  int roomX, roomY;
  int size;
  int lightRad;
  int damage;
  float speed;
  int xp;

  GameObject() {
    loc = new PVector (width/2, height/2);
    vel = new PVector (0, 0);
    hp = 1;
  }

  void show() {
  }

  void act() {
    //move
    loc.add(vel);

    //check for hitting walls
    if (loc.x < width*0.1) loc.x = width*0.1;
    if (loc.x > width*0.9) loc.x = width*0.9;
    if (loc.y < height*0.1) loc.y = height*0.1;
    if (loc.y > height*0.9) loc.y = height*0.9;
  }
  
  boolean inRoomWith(GameObject myObj) {
    return (roomX == myObj.roomX && roomY == myObj.roomY);
  }
  
  boolean isCollidingWith(GameObject myObj) {
    float d = dist(myObj.loc.x, myObj.loc.y, loc.x, loc.y);
    if (inRoomWith(myObj) && d <= size/2 + myObj.size/2 && hp > 0) {
      return true;
    } else {
      return false;
    }
  }
  
}
