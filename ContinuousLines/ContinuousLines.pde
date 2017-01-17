import org.dishevelled.processing.frames.*;

import g4p_controls.*;

import net.java.games.input.*;
import org.gamecontrolplus.*;
import org.gamecontrolplus.gui.*;


// pmberger@orange.fr

float angle = 0.0;
float speed = .05;

float range = 500;

Wave myWave;

void setup() {
  size (750,750);
}


void draw () {
  background(0);
  randomSeed(123);
  pushMatrix();
  strokeWeight(5);
  translate(0,height/2);
  
  for(int i = 0; i < 1; i++) {

    stroke(random(255),random(255),random(200,255),random(100,200));
    myWave = new Wave(int(random(width)),int(random(width)));
    
    myWave.display();
  }
  
  angle += speed;
  popMatrix();
}



class Wave {
  float b1x;
  float b1y;
  float b2x;
  float b2y;
  float sinval;
  float cosval;
 
  
  Wave(float x1, float x2) {

    b1x = x1;
    b2x = x2;
  }
  
  void display() {

    sinval = sin(random(angle));
    cosval = cos(random(angle));
    float b1y =  (sinval * range);
    float b2y = (cosval * range);

    noFill();
    beginShape();
    vertex(50,0);
    bezierVertex(b1x,b1y,b2x,b2y,700,-0);
    endShape(); 
  }
}
 