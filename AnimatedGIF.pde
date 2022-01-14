class AnimatedGIF {

  PImage[] images;
  int currentFrame;
  float x, y, w, h;
  int rate = 1;

  AnimatedGIF(int n, int r, String prefix, String suffix) {
    x = 0;
    y = 0;
    w = width;
    h = height;
    images = new PImage[n];
    loadImages(prefix, suffix);
    currentFrame = 0;
    rate = r;
  }
  
  AnimatedGIF(int n, String prefix, String suffix, float x1, float y1, float wid, float hei) {
    x = x1;
    y = y1;
    w = wid;
    h = hei;
    
    images = new PImage[n];
    loadImages(prefix, suffix);
    currentFrame = 0;
    rate = 1;
  }

  void show() {
    if (currentFrame >= images.length) currentFrame = 0;
    image(images[currentFrame], x, y, w, h);
    //println(x, y, w, h);
    if (frameCount % rate == 0) currentFrame++;
  }
  
  void show(float _x, float _y, float _w, float _h) {
    if (currentFrame >= images.length) currentFrame = 0;
    image(images[currentFrame], _x, _y, _w, _h);
    //println(x, y, w, h);
    if (frameCount % rate == 0) currentFrame++;
  }

  void loadImages(String prefix, String suffix) {
    int i = 0;
    while (i < images.length) {
      String leadingZero = "";
      if (images.length <= 10) leadingZero = "";
      else if (images.length <= 100) {
        if (i < 10) leadingZero = "0";
        else leadingZero = "";
      } else if (images.length > 100) {
        if (i < 10) leadingZero = "00";
        else if (i < 100) leadingZero = "0";
        else leadingZero = "";
      }
      images[i] = loadImage(prefix+leadingZero+i+suffix);
      i++;
    }
  }
} //end of class
