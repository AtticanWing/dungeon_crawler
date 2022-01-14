class DarknessCell {
  float opacity;
  float x, y, size;
  
  DarknessCell(float _x, float _y, float s) {
    size = s;
    x = _x;
    y = _y;
    opacity = 0;
  }
  
  void show() {
    rectMode(CORNER);
    float d = dist(x, y, myHero.loc.x, myHero.loc.y);
    opacity = map(d, 0, 500, 0, 255);
    noStroke();
    fill(black, opacity);
    square(x, y, size);
  }
  
}
