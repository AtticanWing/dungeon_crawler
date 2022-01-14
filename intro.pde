void intro() {
  int t = 230;

  introGIF.show();
  introButton.show();
  textFont(title);
  
  textSize(90);
  fill(terra, t);
  //rect(400,100, 200,50);
  text("DUNGEON    LEGENDS", 400,100);
  //change transparency of title
  
  if (introButton.clicked) {
    mode = GAME;
  }
}
