void pause() {
  imageMode(CORNER);
  image(pausebg, 0, 0, width, height);
  cursor();
  textSize(70);
  fill(0, 150);
  text("CHARACTER    UPGRADES", width/2, 80);
  textSize(50);
  fill(0, 120);
  text("you  have  " + myHero.xp + "  xp", width/2, 150);
  text("HP :  " + myHero.hpMax, 270, 243);
  text("SPEED :  " + myHero.speed, 300, 343);
  text("DAMAGE :  " + myHero.damage, 310, 443);
  textSize(25);
  text("COST : " + 5*hpscale + "  XP", 260, 285);
  text("COST : " + 10*speedscale + "  XP", 265, 385);
  text("COST : " + 5*dmgscale + "  XP", 260, 485);

  upgradebutton.show();
  upgradebutton1.show();
  upgradebutton2.show();
  pausebutton.show();

  if (upgradeshow) {
    fill(255, int(random(106, 255)), 106);
    //println("diff");
    upgradeTimer++;
    if (upgradeTimer >= 20) {
      upgradeshow = false;
      upgradeTimer = 0;
    }
  } else {
    fill(0, 120);
  }
  strokeWeight(5);
  stroke(0);
  rect(515, 225, 200, 250);
  heroResized.show(500, 240, 250, 250);

  drawpauseGameObjects();

  if (pausebutton.clicked) {
    mode = GAME;
  }
  if (upgradebutton.clicked && myHero.xp >= 5*hpscale) {
    myHero.hpMax += 5;
    myHero.hp += 5;
    myHero.xp -= 5*hpscale;
    hpscale++;
    createParticles();
  }
  if (upgradebutton1.clicked && myHero.xp >= 10*speedscale) {
    myHero.speed += 1;
    myHero.xp -= 10*speedscale;
    speedscale++;
    createParticles();
  }
  if (upgradebutton2.clicked && myHero.xp >= 5*dmgscale) {
    myHero.damage += 1;
    myHero.xp -= 5*dmgscale;
    dmgscale++;
    createParticles();
  }
}

void createParticles() {
  color g = int(random(106, 255));
  int n = 0;
  while (n < 50) {
    g = int(random(106, 255));
    myObjects.add(new Particles(int(random(0, 30)), int(random(520, 700)), int(random(250, 450)), 255, g, 106, true));
    n++;
    upgradeshow = true;
  }
}
void drawpauseGameObjects() {
  for (int i = 0; i < myObjects.size(); i++) {
    GameObject obj  = myObjects.get(i);
    if (obj instanceof Particles) {
      obj.show();
      obj.act();
    }
  }
}
