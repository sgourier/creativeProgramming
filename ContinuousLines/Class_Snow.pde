
class Snow {
  PVector location;
  PVector acceleration;
  PVector velocity;
  PVector wind;
  PVector gravity;

  float snowHeight, snowWidth;
  float mass;

  boolean death = false;

  Snow() 
  {
    location = new PVector((float) random(width) / width, 0);
    wind = new PVector(random(-0.001, 0.001), 0);
    gravity = new PVector(0, 0.001);
  }

  void display() {
    drawSnow();
    moveSnow();
  }

  void drawSnow() {
    noStroke();
    fill(255, 200);
    wind.x = random(-0.001, 0.001);
    addForce(location.x, location.y, wind.x, gravity.y);
    location.x += wind.x;
    location.y += gravity.y;
  }
  void moveSnow() {
    //if (location.y > 1000+snowHeight) { //Only for 3D
    if (location.y > height) {
      death = true;
    }
  }
}

class Wind {
  PVector location;
  PVector acceleration;
  PVector velocity;
  PVector wind;
  PVector gravity;

  float snowHeight, snowWidth;
  float mass;

  boolean death = false;

  Wind() 
  {
    location = new PVector(0, (float) random(height) / height);
    wind = new PVector(0.006, 0);
    gravity = new PVector(0, random(-0.001, 0.001));
  }

  void display() {
    drawWind();
    moveWind();
  }

  void drawWind() {
    noStroke();
    fill(255, 200);
    gravity.x = random(-0.001, 0.001);
    addForce(location.x, location.y, wind.x, gravity.y);
    location.x += wind.x;
    location.y += gravity.y;
  }
  
  void moveWind() {
    //if (location.y > 1000+snowHeight) { //Only for 3D
    if (location.x > width) {
      death = true;
    }
  }
}
void loadWind() {
  for (int i = 0; i < 1; i++) {
    wind.add(new Wind());
  }
}
void loadSnow() {
  for (int i = 0; i < 1; i++) {
    snows.add(new Snow());
  }
}

void drawSnow() {
  for (Snow s: snows) {
    s.display();
  }
}
void drawWind() {
  for (Wind w: wind) {
    w.display();
  }
}

void addSnow() {
  snows.add(new Snow());
}
void addWind() {
  wind.add(new Wind());
}