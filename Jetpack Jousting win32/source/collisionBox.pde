class collisionBox
{
  float x;
  float y;
  float w;
  float h;
  
  collisionBox(float x, float y, float w, float h)
  {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
  }
  
  void boxCreation()
  {
    pushStyle();
    rectMode(CORNER);
    rect(x, y, w, h);
    popStyle();
  }
  
  
}
