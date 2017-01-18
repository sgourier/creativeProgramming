
// pmberger@orange.fr
// --------------------------------------------------
// Import Librairies
// --------------------------------------------------
import org.dishevelled.processing.frames.*;

import g4p_controls.*;
import java.util.*;
import net.java.games.input.*;
import org.gamecontrolplus.*;
import org.gamecontrolplus.gui.*;
// --------------------------------------------------

// --------------------------------------------------
// Variables Globales
// --------------------------------------------------
static  float sizex;
static  float sizey;

final float FLUID_WIDTH = 250;
final static int maxParticles = 2000;
static int w;
static int h;

float invWidth, invHeight;    // inverse of screen dimensions
float aspectRatio, aspectRatio2;

MSAFluidSolver2D fluidSolver;
ParticleSystem particleSystem;

//Variables manette
boolean water = false;
boolean fire = false;
boolean earth = false;
boolean air = false;

PGraphics tree;
PGraphics fluid;

float x1StickValue = 0;
float y1StickValue = 0;
float x2StickValue = 0;
float y2StickValue = 0;
ControlIO control;
Configuration config;
ControlDevice gpad;

PImage imgFluid;
boolean untouched=true;

pathfinder[] paths = new pathfinder[0];
int num = 2;
static int count;

ArrayList<Snow> snows;
ArrayList<Wind> wind;

int elementChoice = 0;

// --------------------------------------------------


// --------------------------------------------------
// Functions
// --------------------------------------------------

// --------------------------------------------------
void setup() 
{
  size (1366,768, P2D);
      smooth();
  fluid = createGraphics(width, height);
  
  // Fluid Init
  w=width;
  h=height;
  textAlign(CENTER,CENTER);
  invWidth = 1.0f/width;
  invHeight = 1.0f/height;
  aspectRatio = width * invHeight;
  aspectRatio2 = aspectRatio * aspectRatio;

  // create fluid and set options
  fluidSolver = new MSAFluidSolver2D((int)(FLUID_WIDTH), (int)(FLUID_WIDTH * height/width));
  fluidSolver.enableRGB(true).setFadeSpeed(0.003f).setDeltaT(0.5f).setVisc(0.0001f);

  // create image to hold fluid picture
  imgFluid = createImage(fluidSolver.getWidth(), fluidSolver.getHeight(), ARGB);

  // create particle system
  particleSystem = new ParticleSystem();   
  /*
    // Initialise the ControlIO
  control = ControlIO.getInstance(this);
  // Find a device that matches the configuration file
  gpad = control.getMatchedDevice("gamepad_inputs");
  if (gpad == null) {
    println("No suitable device configured");
    System.exit(-1); // End the program NOW!
  }*/
  
  snows = new ArrayList<Snow>();
  wind = new ArrayList<Wind>();
  loadSnow();
  loadWind();
}
// --------------------------------------------------

// --------------------------------------------------
void draw () 
{
   
  
  fluid.beginDraw();
    
    fluidSolver.update();
    for(int i=0; i<fluidSolver.getNumCells(); i++) 
    {
      int d = 2;
      switch (elementChoice)
      {
       case 0: // Water
        imgFluid.pixels[i] = color(0,0, fluidSolver.b[i] * d);
         break;
       case 1: // Earth
        imgFluid.pixels[i] = color(0, fluidSolver.g[i] * d, 0);
         break;
       case 2: // Fire
        imgFluid.pixels[i] = color(fluidSolver.r[i] * d ,0, 0);
         break;
       case 3: // Air
        imgFluid.pixels[i] = color(fluidSolver.r[i] * d ,fluidSolver.r[i] * d, fluidSolver.r[i] * d);
         break;
      }
    }         
    imgFluid.updatePixels();
   image(imgFluid, 0, 0, width, height);
      
  
  //lights();  //Only for 3D
    particleSystem.updateAndDraw();
     stroke(200, 0, 0, 200);

    if(elementChoice == 0)
    {
    if ((frameCount % 10) == 0) {
      addSnow();
    }
    for(int i = 0; i < snows.size(); i++){
      Snow s = snows.get(i);
      if(s.death){
        snows.remove(s);
      } 
    }
    drawSnow();
    }
    
    
    if(elementChoice == 2)
    {
     for (int i = 0; i < paths.length; i++) {
        PVector loc = paths[i].location;
        PVector lastLoc = paths[i].lastLocation;
        strokeWeight(paths[i].diameter);
        line(lastLoc.x, lastLoc.y, loc.x, loc.y);
        paths[i].update();    
        
        float mouseNormX = loc.x * invWidth;
        float mouseNormY = loc.y * invHeight;
        float mouseVelX = (loc.x - lastLoc.x) * invWidth;
        float mouseVelY = (loc.y - lastLoc.y) * invHeight;
      
        addForce(mouseNormX, mouseNormY, mouseVelX, mouseVelY);
      }
    }
    
    if(elementChoice == 3)
    {
    if ((frameCount % 10) == 0) {
      addWind();
    }
    for(int i = 0; i < wind.size(); i++){
      Wind w = wind.get(i);
      if(w.death){
        wind.remove(w);
      } 
    }
    drawWind();
    }
   fluid.endDraw();
  image(fluid, 0, 0, width, height);
   
 // 
  

}
// --------------------------------------------------

// --------------------------------------------------
public void mouseDragged() 
{
  untouched=false;    
  float mouseNormX = mouseX * invWidth;
  float mouseNormY = mouseY * invHeight;
  float mouseVelX = (mouseX - pmouseX) * invWidth;
  float mouseVelY = (mouseY - pmouseY) * invHeight;

  addForce(mouseNormX, mouseNormY, mouseVelX, mouseVelY);
}
// --------------------------------------------------

public void mousePressed()
{
  if(elementChoice == 2)
  {
    count = 0;
    paths = new pathfinder[num];
    for(int i = 0; i < num; i++) paths[i] = new pathfinder();
  }
  
  
}


// --------------------------------------------------

public void getControllerStatus()
{
    water = gpad.getButton("WATER").pressed();
    fire = gpad.getButton("FIRE").pressed();
    earth = gpad.getButton("EARTH").pressed();
    air = gpad.getButton("AIR").pressed();
    
    x1StickValue = gpad.getSlider("XPOS1").getValue();
    y1StickValue = gpad.getSlider("YPOS1").getValue();
    
    x2StickValue = gpad.getSlider("XPOS2").getValue();
    y2StickValue = gpad.getSlider("YPOS2").getValue();
    
    /*if(xStickValue != 0)
      elX += xStickValue;
    if(yStickValue != 0)  
      elY += yStickValue;*/
}

void keyPressed() 
{
  snows = new ArrayList<Snow>();
  wind = new ArrayList<Wind>();
  loadSnow();
  loadWind();
  switch(key)
  {
    case '0': elementChoice = 0;
    break;
    case '1': elementChoice = 1;
    break;
    case '2': elementChoice = 2;
    break;
    case '3': elementChoice = 3;
    break;
  }
}