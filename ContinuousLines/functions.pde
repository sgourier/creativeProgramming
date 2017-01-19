int previousNote = 0;
// add force and dye to fluid, and create particles
public void addForce(float x, float y, float dx, float dy, boolean particles) 
{
  float speed = dx * dx  + dy * dy * aspectRatio2;    // balance the x and y components of speed with the screen aspect ratio

  if(speed > 0) 
  {
    if(x<0) x = 0;
    else if(x>1) x = 1;
    if(y<0) y = 0;
    else if(y>1) y = 1;

    float colorMult = 5;
    float velocityMult = 30.0f;

    int index = fluidSolver.getIndexForNormalizedPosition(x, y);

    int drawColor;

    colorMode(HSB, 360, 1, 1);
    float hue = ((x + y) * 180 + frameCount) % 360;
    drawColor = color(hue, 1, 1);
    colorMode(RGB, 1);

    fluidSolver.rOld[index]  += red(drawColor) * colorMult;
    fluidSolver.gOld[index]  += green(drawColor) * colorMult;
    fluidSolver.bOld[index]  += blue(drawColor) * colorMult;
    
    if(particles)
    {
      particleSystem.addParticles(x * width, y * height, 5);
    }
    fluidSolver.uOld[index] += dx * velocityMult;
    fluidSolver.vOld[index] += dy * velocityMult;
    
  }
}

import ddf.minim.*;

AudioPlayer do0, re0, mi0, fa0, sol0, la0, si0, do1, re1, mi1, fa1, sol1, la1, si1, do2, re2, mi2, fa2, sol2, la2, si2, do3;
AudioPlayer percu0, percu1, percu2;


void playSound(float x, float y){
  
  x++;
  //y++;
  
  x *= 22;
 // y *= 50; 
  
  int note = int(x / 2);
  
   if(previousNote == note)
    return;
  
  previousNote = note;
  
  
  float volume = - (y /*/ 100)*/);
  
  println("volu :",volume);
  
  
  switch(note){
  case 0:
    do0.rewind();
    do0.setGain(volume);
    do0.play();
    break;
  case 1:
    re0.rewind();
    re0.setGain(volume);
    re0.play();
    break;
  case 2:
    mi0.rewind();
    mi0.setGain(volume);
    mi0.play();
    break;
  case 3:
    fa0.rewind();
    fa0.setGain(volume);
    fa0.play();
    break;
  case 4:
    sol0.rewind();
    sol0.setGain(volume);
    sol0.play();
    break;
  case 5:
    la0.rewind();
    la0.setGain(volume);
    la0.play();
    break;
  case 6:
    si0.rewind();
    si0.setGain(volume);
    si0.play();
    break;
  case 7:
    do1.rewind();
    do1.setGain(volume);
    do1.play();
    break;
  case 8:
    re1.rewind();
    re1.setGain(volume);
    re1.play();
    break;
  case 9:
    mi1.rewind();
    mi1.setGain(volume);
    mi1.play();
    break;
  case 10:
    fa1.rewind();
    fa1.setGain(volume);
    fa1.play();
    break;
  case 11:
    sol1.rewind();
    sol1.setGain(volume);
    sol1.play();
    break;
  case 12:
    la1.rewind();
    la1.setGain(volume);
    la1.play();
    break;
  case 13:
    si1.rewind();
    si1.setGain(volume);
    si1.play();
    break;
  case 14:
    do2.rewind();
    do2.setGain(volume);
    do2.play();
    break;
  case 15:
    re2.rewind();
    re2.setGain(volume);
    re2.play();
    break;
  case 16:
    mi2.rewind();
    mi2.setGain(volume);
    mi2.play();
    break;
  case 17:
    fa2.rewind();
    fa2.setGain(volume);
    fa2.play();
    break;
  case 18:
    sol2.rewind();
    sol2.setGain(volume);
    sol2.play();
    break;
  case 19:
    la2.rewind();
    la2.setGain(volume);
    la2.play();
    break;
  case 20:
    si2.rewind();
    si2.setGain(volume);
    si2.play();
    break;
  case 21:
    do3.rewind();
    do3.setGain(volume);
    do3.play();
    break;
  }
}

public void configureNotes(){
   minim = new Minim(this);
  do0 = minim.loadFile("notes/0-1-do.mp3");
  re0 = minim.loadFile("notes/0-2-re.mp3");
  mi0 = minim.loadFile("notes/0-3-mi.mp3");
  fa0 = minim.loadFile("notes/0-4-fa.mp3");
  sol0 = minim.loadFile("notes/0-5-sol.mp3");
  la0 = minim.loadFile("notes/0-6-la.mp3");
  si0 = minim.loadFile("notes/0-7-si.mp3");
  do1 = minim.loadFile("notes/1-1-do.mp3");
  re1 = minim.loadFile("notes/1-2-re.mp3");
  mi1 = minim.loadFile("notes/1-3-mi.mp3");
  fa1 = minim.loadFile("notes/1-4-fa.mp3");
  sol1 = minim.loadFile("notes/1-5-sol.mp3");
  la1 = minim.loadFile("notes/1-6-la.mp3");
  si1 = minim.loadFile("notes/1-7-si.mp3");
  do2 = minim.loadFile("notes/2-1-do.mp3");
  re2 = minim.loadFile("notes/2-2-re.mp3");
  mi2 = minim.loadFile("notes/2-3-mi.mp3");
  fa2 = minim.loadFile("notes/2-4-fa.mp3");
  sol2 = minim.loadFile("notes/2-5-sol.mp3");
  la2 = minim.loadFile("notes/2-6-la.mp3");
  si2 = minim.loadFile("notes/2-7-si.mp3");
  do3 = minim.loadFile("notes/3-1-do.mp3");
}