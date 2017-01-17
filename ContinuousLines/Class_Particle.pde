class Particle 
{
  final static float MOMENTUM = 0.5f;
  final static float FLUID_FORCE = 0.6f;

  float x, y;
  float vx, vy;
  float radius;       // particle's size
  float alpha;
  float mass;

  public void init(float x, float y) 
  {
    this.x = x;
    this.y = y;
    vx = 0;
    vy = 0;
    radius = 5;
    alpha  = random(0.3f, 1);
    mass = random(0.1f, 1);
  }


  public void update() 
  {
    // only update if particle is visible
    if(alpha == 0) return;

    // read fluid info and add to velocity
    int fluidIndex = fluidSolver.getIndexForNormalizedPosition(x * invWidth, y * invHeight);
    vx = fluidSolver.u[fluidIndex] * width * mass * FLUID_FORCE + vx * MOMENTUM;
    vy = fluidSolver.v[fluidIndex] * height * mass * FLUID_FORCE + vy * MOMENTUM;

    // update position
    x += vx;
    y += vy;

    // bounce of edges
    if(x<0) 
    {
      x = 0;
      vx *= -1;
    }
    else if(x > width) 
    {
      x = width;
      vx *= -1;
    }

    if(y<0) 
    {
      y = 0;
      vy *= -1;
    }
    else if(y > height) 
    {
      y = height;
      vy *= -1;
    }

    // hackish way to make particles glitter when the slow down a lot
    if(vx * vx + vy * vy < 1) 
    {
      vx = random(-1, 1);
      vy = random(-1, 1);
    }

    // fade out a bit (and kill if alpha == 0);
    alpha *= 0.999f;
    if(alpha < 0.01f) alpha = 0;
  }
  public void drawOldSchool() 
  {
    strokeWeight(alpha*1.5f);
    stroke(alpha, alpha, alpha,alpha);
    line(x-vx, y-vy,x, y);
  }
}