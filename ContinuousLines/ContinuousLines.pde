
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

PImage imgFluid;
boolean untouched=true;
// --------------------------------------------------


// --------------------------------------------------
// Functions
// --------------------------------------------------

// --------------------------------------------------
void setup() 
{
  size (1366,768, P2D);
  
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
}
// --------------------------------------------------

// --------------------------------------------------
void draw () 
{
  
  fluidSolver.update();
  for(int i=0; i<fluidSolver.getNumCells(); i++) 
  {
    int d = 2;
    imgFluid.pixels[i] = color(0, 0, fluidSolver.b[i] * d);
  }         
  imgFluid.updatePixels();
  image(imgFluid, 0, 0, width, height);     
  particleSystem.updateAndDraw();   
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

 