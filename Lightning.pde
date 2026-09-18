import java.util.ArrayList;

int fadeSpeed = 15;
int xChange = 0;
int yChange = 0;

int winSize = 300;

int randColor = (int)(Math.random() * 150 + 102);
float fadeAlpha = 0;

ArrayList<Integer> xPoints = new ArrayList<Integer>();
ArrayList<Integer> yPoints = new ArrayList<Integer>();

//Raindrops
ArrayList<RainDrop> rain = new ArrayList<RainDrop>();
int totalDrops = 150;

void setup() {
  size(300,300);
  strokeWeight(3);
  background(0);
  
  for (int i = 1; i <= totalDrops; i++) {
    rain.add(new RainDrop());
  }
}

void draw() {
  if (fadeAlpha > 0) {
    float flashBrightness = map(fadeAlpha, 0, 255, 0, 45);
    background(flashBrightness - 10, flashBrightness - 10, flashBrightness);
  } else {
    background(0);
  }
  
  for (RainDrop drop : rain) {
    drop.fall();
    drop.show(fadeAlpha, randColor);
  }
  
  if (fadeAlpha > 0){
    int listSize = 0;

    for (String item : xPoints) {
      listSize++;
    }
    
    fadeAlpha -= fadeSpeed;
    stroke(randColor, fadeAlpha * 0.15);
    strokeWeight(15);
    
    for (int i = 0; i < listSize-1; i++) {
      line(xPoints.get(i), yPoints.get(i), xPoints.get(i+1), yPoints.get(i+1));
    }
    
    stroke(255, fadeAlpha);
    strokeWeight(3);
    
    for (int i = 0; i < listSize-1; i++) {
      line(xPoints.get(i), yPoints.get(i), xPoints.get(i+1), yPoints.get(i+1));
    }
  }
}

void drawLightning(int end) {
  xPoints.clear();
  yPoints.clear();
  
  randColor = (int)(Math.random() * 150 + 102);
  fadeAlpha = 255;
  
  int endX = end;
  int endY = 0;
  
  xPoints.add(endX);
  yPoints.add(endY);
  
  while (endY < winSize) {
    xChange = (int)(Math.random() * 18 - 9);
    yChange = (int)((Math.random() * 10));
    
    endX += xChange;
    endY += yChange;
    
    endX = constrain(endX, 0, winSize);
    
    xPoints.add(endX);
    yPoints.add(endY);
  }
}

void mousePressed() {
  drawLightning(mouseX);
}

void keyPressed() {
  drawLightning((int)(Math.random()*winSize));
}

class RainDrop {
  int x = 0;
  int y = 0;
  int speed = 0;
  int len = 0;
  
  RainDrop() {
    x = (int)(Math.random() * winSize);
    y = (int)(Math.random() * 700 - 700);
    speed = (int)(Math.random() * 7 + 8);
    len = (int)(Math.random() * 10 + 10);
  }
  
  void fall() {
    y += speed;
    
    if (y > winSize) {
      x = (int)(Math.random() * winSize);
      y = (int)(Math.random() * 500 - 500);
      speed = (int)(Math.random() * 7 + 8);
      len = (int)(Math.random() * 10 + 10);
    }
  }
  
  void show(float lightningAlpha, int lightningColor) {
    if (lightningAlpha > 0) {
      strokeWeight(2.0);
      stroke(lightningColor, lightningAlpha * 0.6);
    } else {
      stroke(80, 80, 100);
      strokeWeight(1.2);
    }
    
    line(x, y, x, y + len);
  }
}
