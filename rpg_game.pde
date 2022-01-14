//Vanessa Lu
//RPG Game

//mode framework----------------------------------------------------------------------------------------------
final int INTRO = 0;
final int GAME  = 1;
final int GAMEOVER = 2;
final int PAUSE = 3;
int mode;

//dropped item types
final int AMMO = 0;
final int HEALTH = 1;
final int GUN = 2;
final int SPEED = 3;
final int POWER = 4;
final int GOLD = 5;
PImage currentGun;

//font variable-----------------------------------------------------------------------------------------------
PFont title;

//map
PImage map;
color nRoom, eRoom, sRoom, wRoom;
int roomLoc;

boolean mouseReleased;
boolean wasPressed;
boolean win;
boolean tactile;

color white = 255;
color black = 0;
color darkblue = #181F29;
color navyblue = #033649;
color turquoise = #036564;
color terra = #CDB380;
color grey = #E8DDCB;
color green = #32502E;
//map colours
color pastelpink = #FFBCCD;
color pastelblue = #BCE9FF;
color pastelyellow = #fff898;
color pastelgreen = #baff8b;
color pastelpurple = #eca9f7;

//GIFs
AnimatedGIF introGIF;
AnimatedGIF heroIdle;
AnimatedGIF heroIdleLeft;
AnimatedGIF heroRight;
AnimatedGIF heroLeft;
AnimatedGIF heroResized;
AnimatedGIF goblinRight;
AnimatedGIF goblinLeft;
AnimatedGIF goblinIdle;
AnimatedGIF batRight;
AnimatedGIF batLeft;
AnimatedGIF gameover1;
AnimatedGIF gameover2;
AnimatedGIF slimeRight;
AnimatedGIF slimeLeft;
AnimatedGIF summonerLeft;
AnimatedGIF summonerRight;

//Game Objects
ArrayList<GameObject> myObjects;
ArrayList<DarknessCell> darkness;
Hero myHero;
int numEnemy;

//keyboard
boolean w, a, s, d, p, space;

//grid planning variables
int gridx, gridy;

//buttons
Button introButton;
ButtonImage pausebutton;
ButtonImage upgradebutton;
ButtonImage upgradebutton1;
ButtonImage upgradebutton2;
ButtonImage replay;

//images
PImage tile, door;
PImage crosshair, pattern, pattern1;
PImage hpPotion, ammo, shotgun, pistol, sniper, hose;
PImage pausebg, pauseb, pauseb1, upgrade, upgrade1, replay1, replay2;

//timers
int immuneTimer;
int threshold;
int upgradeTimer = 0;

//upgrade variables
int hpscale = 1;
int speedscale = 1;
int dmgscale = 1;
boolean upgradeshow;

void setup() { 
  size(800, 600);
  mode = INTRO;
  numEnemy = 0;
  win = false;

  //load GIFs
  introGIF = new AnimatedGIF(21, 2, "frame_", "_delay-0.12s.png");
  heroIdle = new AnimatedGIF(6, 2, "knight/knight_idle_anim_f", ".png");
  heroRight = new AnimatedGIF(6, 2, "knight/knight_run_anim_f", ".png");
  heroLeft = new AnimatedGIF(6, 2, "knight/knight_run_left_anim_f", ".png");
  heroIdleLeft = new AnimatedGIF(6, 2, "knight/knight_idle_left_anim_f", ".png");
  heroResized = new AnimatedGIF(9, 1, "knightresized/knightresized", ".png");
  goblinRight = new AnimatedGIF(6, 2, "goblin/goblin_", ".png");
  goblinLeft = new AnimatedGIF(6, 2, "goblinL/goblinL_", ".png");
  goblinIdle = new AnimatedGIF(6, 4, "goblinI/goblinI_", ".png");
  batRight = new AnimatedGIF(5, 3, "bat/bat_", ".png");
  batLeft = new AnimatedGIF(5, 3, "batL/batL_", ".png");
  gameover1 = new AnimatedGIF(23, 5, "gameover1/frame_", "_delay-0.2s.png");
  gameover2 = new AnimatedGIF(4, 8, "gameover2_1/frame_", "_delay-0.3s.png");
  slimeRight = new AnimatedGIF(6, 3, "slime/slime_", ".png");
  slimeLeft = new AnimatedGIF(6, 3, "slimeL/slimeL_", ".png");
  summonerLeft = new AnimatedGIF(8, 2, "summoner/frame_", "_delay-0.1s.png");
  summonerRight = new AnimatedGIF(8, 2, "summonerR/frame_", "_delay-0.1s.png");
  
  //images
  map = loadImage("map.png");
  tile = loadImage("tile2_2.jpg");
  crosshair = loadImage("crosshair.png");
  door = loadImage("door.png");
  hpPotion = loadImage("HealthPotion.png");
  pausebg = loadImage("pause_map.png");
  pauseb = loadImage("pausebutton.png");
  upgrade = loadImage("upgrade (2).png");
  upgrade1 = loadImage("upgrade (3).png");
  pauseb1 = loadImage("pausebutton1.png");
  ammo = loadImage("bullet.png");
  shotgun = loadImage("shotgun.png");
  pistol = loadImage("pistol.png");
  sniper = loadImage("sniper.png");
  hose = loadImage("hose.png");
  replay1 = loadImage("endbutton1.png");
  replay2 = loadImage("endbutton2.png");
  pattern = loadImage("pattern.png");
  pattern1 = loadImage("pattern1.png");

  title = createFont("Enchanted Land.otf", 200);
  textAlign(CENTER, CENTER);

  //Create objects
  myObjects = new ArrayList<GameObject>(); //1000 ?
  myHero = new Hero();
  myObjects.add(myHero);

  //Create darkness
  darkness = new ArrayList<DarknessCell>(1000);

  gridx = 0;
  gridy = 0;
  int size = 5;
  while (gridy < height) {
    darkness.add(new DarknessCell(gridx, gridy, size));
    gridx = gridx + size;
    if (gridx > width) {
      gridx = 0;
      gridy = gridy + size;
    }
  }

  //load buttons
  introButton  = new Button("START", 378, 550, 100, 50, navyblue, grey);
  pausebutton = new ButtonImage(pauseb, width-220, 480, 80, 70, pauseb1);
  upgradebutton = new ButtonImage(upgrade, 125, 225, 50, 50, upgrade1);
  upgradebutton1 = new ButtonImage(upgrade, 125, 325, 50, 50, upgrade1);
  upgradebutton2 = new ButtonImage(upgrade, 125, 425, 50, 50, upgrade1);
  replay = new ButtonImage(replay1, 300, 480, 190, 90, replay2);

  //loading the enemies from the map
  int x = 0;
  int y = 0;
  while (y < map.height) {
    roomLoc = int(random(1, 5));
    color roomColor = map.get(x, y);
    if (roomColor == pastelpink) {
      myObjects.add(new Enemy(x, y));
      myObjects.add(new Summoner(x, y, roomLoc));
    }
    if (roomColor == pastelblue) {
      myObjects.add(new Follower(x, y, roomLoc));
      if(roomLoc <= 2) roomLoc += 2;
      else roomLoc -= 2;
      myObjects.add(new Follower(x, y, roomLoc));
      myObjects.add(new Enemy(x, y));
    }
    if (roomColor == pastelgreen) { 
      myObjects.add(new Follower(x, y, 1));
      myObjects.add(new Follower(x, y, 2));
      myObjects.add(new Follower(x, y, 3));
      myObjects.add(new Follower(x, y, 4));
    }
    if (roomColor == pastelpurple) { 
      myObjects.add(new Goblin(x, y, 1));
      myObjects.add(new Goblin(x, y, 4));
      myObjects.add(new Enemy(x, y));
    }
    if (roomColor == pastelyellow) { 
      myObjects.add(new Goblin(x, y, roomLoc));
      if(roomLoc <= 2) roomLoc += 1;
      else roomLoc -= 1;
      myObjects.add(new Summoner(x, y, roomLoc));
      if(roomLoc <= 2) roomLoc += 2;
      else roomLoc -= 2;
      myObjects.add(new Follower(x, y, roomLoc));
    }
    x++;
    if (x == map.width) {
      x = 0;
      y++;
    }
  }
}

void draw() {

  click();

  //mode framework------------------------------------------------------------------------------------------------
  if (mode == INTRO) {
    intro();
  } else if (mode == GAME) {
    game();
  } else if (mode == GAMEOVER) {
    gameover();
  } else if (mode == PAUSE) {
    pause();
  } else {
    println("?");
  }
}

void click() {
  mouseReleased = false;
  if (mousePressed) wasPressed = true;
  if (wasPressed && !mousePressed) {
    mouseReleased = true;
    wasPressed = false;
  }
}

//check if everyth works properly
//https://www.colourlovers.com/palette/1717293/Platform
//https://www.colourlovers.com/palette/1171230/Under_construction
//https://www.colourlovers.com/palette/292482/Terra
//https://steamuserimages-a.akamaihd.net/ugc/92722164049515020/972FF94EC0C15A81B3241962ECDE2039789EB64F/?imw=637&imh=358&ima=fit&impolicy=Letterbox&imcolor=%23000000&letterbox=true
//https://e7.pngegg.com/pngimages/965/676/png-clipart-stone-wall-sprite-tile-based-video-game-isometric-graphics-in-video-games-and-pixel-art-sprite-game-angle-thumbnail.png
