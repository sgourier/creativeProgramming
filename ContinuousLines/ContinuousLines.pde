
// pmberger@orange.fr
// --------------------------------------------------
// Import Librairies
// --------------------------------------------------
import org.dishevelled.processing.frames.*;

import g4p_controls.*;

import net.java.games.input.*;
import org.gamecontrolplus.*;
import org.gamecontrolplus.gui.*;
// --------------------------------------------------

// --------------------------------------------------
// Variables Globales
// --------------------------------------------------
static  float sizex;
static  float sizey;

final float FLUID_WIDTH = 150;
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
  tree = createGraphics(width, height);
  
  
  
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
      imgFluid.pixels[i] = color(fluidSolver.r[i] * d, fluidSolver.g[i] * d, fluidSolver.b[i] * d);
    }         
    imgFluid.updatePixels();
   image(imgFluid, 0, 0, width, height);    
    particleSystem.updateAndDraw();
    
  fluid.endDraw();
  image(fluid, 0, 0, width, height);
  
   tree.beginDraw();
     stroke(200, 0, 0, 200);

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
   tree.endDraw();
  image(tree, 0, 0, width, height);
   
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
  count = 0;
  paths = new pathfinder[num];
  for(int i = 0; i < num; i++) paths[i] = new pathfinder();
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