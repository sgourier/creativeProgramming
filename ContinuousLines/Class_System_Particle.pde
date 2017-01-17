class ParticleSystem 
{
  int curIndex;

  Particle[] particles;

  ParticleSystem() 
  {
    particles = new Particle[maxParticles];
    for(int i=0; i<maxParticles; i++) particles[i] = new Particle();
    curIndex = 0;
  }

  public void updateAndDraw()
  {
    for(int i=0; i<maxParticles; i++) 
    {
      if(particles[i].alpha > 0) 
      {
        particles[i].update();
        particles[i].drawOldSchool();    // use oldschool renderng
      }
    }
  }


  public void addParticles(float x, float y, int count )
  {
    for(int i=0; i<count; i++) addParticle(x + random(-15, 15), y + random(-15, 15));
  }


  public void addParticle(float x, float y) 
  {
    particles[curIndex].init(x, y);
    curIndex++;
    if(curIndex >= maxParticles) curIndex = 0;
  }

}