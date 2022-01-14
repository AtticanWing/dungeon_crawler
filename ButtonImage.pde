class ButtonImage {

  int x, y, w, h;
  boolean clicked;
  PImage currentpic;
  PImage norm, highlight;

  ButtonImage(PImage p, int _x, int _y, int _w, int _h, PImage high) {
    x = _x;
    y = _y;
    w = _w;
    h = _h;
    norm = p;
    highlight = high;
    currentpic = norm;
    clicked = false;
  }

  void show() {
    //rectangle
    imageMode(CORNER);
    if (mouseX > x && mouseX < x+w && mouseY > y && mouseY < y+h) {
      currentpic = highlight;
      tactile = true;
    } else {
      currentpic = norm;
      tactile = false;
    }
    image(currentpic, x, y, w, h);

    if (mouseReleased && mouseX > x && mouseX < x+w && mouseY > y && mouseY < y+h) {
      clicked  = true;
    } else {
      clicked = false;
    }
  }
}
