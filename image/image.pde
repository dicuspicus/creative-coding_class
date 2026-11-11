int MASK_SIZE = 80;

PImage img, copy;
PGraphics mask;

void setup(){
  size(600,600);
  String url = "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRcMBnWXu4_EPvCHWgBKXUDdi3eUXYG6DsGRAZM5iNXxHE7c5uhwOb9sDmS&s=10";
  img = loadImage(url, "jpeg");
  copy = img;
  mask = createGraphics(img.width, img.height);
  windowResize(img.width, img.height);
}

void draw(){
  background(0);
  mousePosEvent();
  copy.mask(mask);
  copy.updatePixels();
  image(img, 0, 0, width, height);
}

void mousePosEvent(){
  mask.beginDraw();
  mask.background(0);
  mask.circle(mouseX, mouseY, MASK_SIZE);
  mask.endDraw();
}
