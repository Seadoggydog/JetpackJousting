class Player
{
  ArrayList<collisionBox> cboxes = new ArrayList<collisionBox>();
  float splodeMoveAmount = 0;
  float posX = 100.0;
  float posY = 720-100;
  float velocityX = 14.0;
  float velocityY = 0.0;
  float gravity = .5;
  boolean onGround = false;
  boolean stunned = false;
  boolean stunStart = true;
  boolean ePlayed = false;
  boolean splode = false;
  boolean shaken = false;
  float stunLength = 1.5;
  float millisHold = 0;
  float dir = 0;
  float rad = 57.295;
  float flame = 0;
  boolean[] keys = new boolean[4];
  
  //customization
  colour[] colours = 
  {
    new colour(255, 0, 0), 
    new colour(0, 255, 0), 
    new colour(0, 0, 255), 
    new colour(255, 255, 255), 
    new colour(100, 100, 100), 
    new colour(255, 207, 31), 
    new colour(111, 50, 86), 
    new colour(118, 24, 24), 
    new colour(61, 13, 72), 
    new colour(69, 219, 182), 
    new colour(224, 224, 151), 
    new colour(255, 200, 180), 
    new colour(255, 83, 3), 
    new colour(250, 150, 200)
  };
  int tool = 0; //sword or lance
  int toolC = 5;
  int numFlames = 0;
  int flameC = 0;
  int packC = 1;
  int baseC = 0;
  int strapC = 4;
  int buckleC = 3;

  Player()
  {
  }

  void startJump()
  {
    //if (onGround)
    //{
    velocityY = -15.0;
    gravity = .01;
    onGround = false;
    //}
  }

  void endJump()
  {
    if (velocityY < -6.0)
      velocityY = -6.0;
    gravity = .2;
  }

  void play()
  {
    if (!splode)
    {
      if (keyPressed)
        keyPressed();
      if (!stunned) 
      {
        if (keys[0])
        {
          startJump();
          dir = 0;
        }
        if (keys[1])
        {
          posX += abs(velocityX);
          dir = 1;
        }
        if (keys[3])
        {
          posX += abs(velocityX) * -1;
          dir = -1;
        }
        if (keys[2])
        {

          if (posY < height - 30) {
            dir = 2;
            velocityY +=3;
          }
        }
      }
      
      for(collisionBox c: cboxes)
      {
        pushStyle();
        fill(255);
        //c.boxCreation();
        popStyle();
        //below
        if(!(posY< c.y) && posY <= c.y + c.h + 100 && dir == 0 && posX >= c.x && posX <= c.x + c.w)
        {
          if (stunStart)
          {
            stunLength = 1.5;
            stunned = true;
            millisHold = millis();
          }
        }
        
        /*if(dir != 0 && posY< 30)
          posY = 30;*/
        //above
        if(!(posY > c.y) && posY >= c.y - 100 && dir == 2 && posX >= c.x && posX <= c.x + c.w)
        {
          if (stunStart)
          {
            stunLength = 1.5;
            stunned = true;
            millisHold = millis();
          }
        }
        
        if(posY > c.y && posY <= c.y + c.h + 20 && posX > c.x && posX < c.x + c.w)
        {
          posY = c.y + c.h + 20;
        }
        
        if(!(posX < c.x) && posX <= c.x + c.w + 100 && dir == -1 && posY >= c.y && posY <= c.y + c.h)
        {
          if (stunStart)
          {
            stunLength = 1.5;
            stunned = true;
            millisHold = millis();
          }
        }
        
        if(!(posX > c.x) && posX >= c.x - 100 && dir == 1 && posY >= c.y-5 && posY <= c.y + c.h+5)
        {
          if (stunStart)
          {
            stunLength = 1.5;
            stunned = true;
            millisHold = millis();
          }
        }
        if(posX >= c.x-10 && posX <= c.x + c.w - 10 && posY >= c.y && posY <= c.y + c.h)
        {
          if(abs(posX - c.x) < abs(posX - (c.x + c.w)))
          {
            println("posY: " + posY + " " + "c.y: " + c.y + " " + "c.y and c.h: " + (c.y+ c.h), width/2, 300);
            posX = c.x -20;
          }
          else
          {
            println("posY: " + posY + " " + "c.y: " + c.y + " " + "c.y and c.h: " + (c.y+ c.h), width/2, 300);
            posX = c.x + c.w + 20;
          }
        }
          
        if(posY <= c.y + c.h && posY >= c.y -13 &&  posX >= c.x && posX <= c.x + c.w)
        {
          println("helo");
          posY = c.y-13;
          /*if(dir != 0)
            velocityY = 0;
          else*/
            velocityY = -1 * abs(velocityY);
        }
          
      }

      /*if (posY >= height - 100 && dir == 2)
      {
        if (stunStart)
        {
          stunLength = 1.5;
          stunned = true;
          millisHold = millis();
        }
      }

      if (posX <= 100 && dir == -1)
      {
        if (stunStart)
        {
          stunned = true;
          millisHold = millis();
        }
      }

      if (posX >= width-100 && dir == 1)
      {
        if (stunStart)
        {
          stunned = true;
          millisHold = millis();
        }
      }*/
      //background(0);
      if (!stunned) {
        update();
      }
      else
      {
        if (stunLength > 0) 
        {
          if(velocityX > 0)
            velocityX = 0;
          if(velocityY > 0)
            velocityY = 0;
          stunStart = false;
          if ((millis() - millisHold) > 500)
          {
            stunLength-=.5;
            millisHold = millis();
          }
          //inCountdown = true;
          fill(255);
          text("P1 stunned for " + stunLength + " seconds.", 140, 40);
        }
        else
        {
          if(dir==2)
            dir = 0;
          else if(dir == -1)
            dir = 1;
          else if((posX < width/2 && posX > width/4) || (posX > width *3/4) || dir == 1)
            dir = -1;
          else
            dir = 1;
          stunned = false;
          stunStart = true;
          velocityX = 14;
          stunLength = 1.5;
        }
      }
      render();
      keyReleased();
    }
    else
    {  
      for(collisionBox c: cboxes)
      {
        c.boxCreation();
      }
      
      if (splodeMoveAmount <40)
      {
        fill(255, 0, 0);
        ellipse(posX - splodeMoveAmount, posY, 1 + splodeMoveAmount, 1 + splodeMoveAmount);
        ellipse(posX, posY - splodeMoveAmount, 1 + splodeMoveAmount, 1 + splodeMoveAmount);
        ellipse(posX + splodeMoveAmount, posY, 1 + splodeMoveAmount, 1 + splodeMoveAmount);
        ellipse(posX, posY + splodeMoveAmount, 1 + splodeMoveAmount, 1 + splodeMoveAmount);
        ellipse(posX + splodeMoveAmount / 1.4, posY + splodeMoveAmount /1.4, 1 + splodeMoveAmount, 1 + splodeMoveAmount);
        ellipse(posX - splodeMoveAmount / 1.4, posY + splodeMoveAmount /1.4, 1 + splodeMoveAmount, 1 + splodeMoveAmount);
        ellipse(posX - splodeMoveAmount / 1.4, posY - splodeMoveAmount /1.4, 1 + splodeMoveAmount, 1 + splodeMoveAmount);
        ellipse(posX + splodeMoveAmount / 1.4, posY - splodeMoveAmount /1.4, 1 + splodeMoveAmount, 1 + splodeMoveAmount);
        if(!shaken)
        {
          translate(4, 0);
          shaken = true;
        }
        else
        {
          translate(-4,0);
          shaken = false;
        }
        
        pushMatrix();
        translate(posX, posY);
        rotate(PI/7);
          
        for(int i = 0; i < 20; i++)
        {
          rotate(PI/7);
          fill(240, 40 + random(200), 29);
          ellipse(0- random(splodeMoveAmount), 0, 1 + random(splodeMoveAmount), 1 + random(splodeMoveAmount));
          fill(240, 40 + random(200), 29);
          ellipse(0, 0 - random(splodeMoveAmount), 1 + random(splodeMoveAmount), 1 + random(splodeMoveAmount));
          fill(240, 40 + random(200), 29);
          ellipse(0 + random(splodeMoveAmount), 0, 1 + random(splodeMoveAmount), 1 + random(splodeMoveAmount));
          fill(240, 40 + random(200), 29);
          ellipse(0, 0 + random(splodeMoveAmount), 1 + random(splodeMoveAmount), 1 + random(splodeMoveAmount));
          fill(240, 40 + random(200), 29);
          ellipse(0 + random(splodeMoveAmount) / 1.4, 0 + random(splodeMoveAmount) /1.4, 1 + random(splodeMoveAmount), 1 + random(splodeMoveAmount));
          fill(240, 40 + random(200), 29);
          ellipse(0 - random(splodeMoveAmount) / 1.4, 0 + random(splodeMoveAmount) /1.4, 1 + random(splodeMoveAmount), 1 + random(splodeMoveAmount));
          fill(240, 40 + random(200), 29);
          ellipse(0 - random(splodeMoveAmount) / 1.4, 0 - random(splodeMoveAmount) /1.4, 1 + random(splodeMoveAmount), 1 + random(splodeMoveAmount));
          fill(240, 40 + random(200), 29);
          ellipse(0 + random(splodeMoveAmount) / 1.4, 0 - random(splodeMoveAmount) /1.4, 1 + random(splodeMoveAmount), 1 + random(splodeMoveAmount));
        }
        popMatrix();
        /*line(posX+ splodeMoveAmount, posY + splodeMoveAmount, posX+ splodeMoveAmount*2, posY + splodeMoveAmount*2)
        line(posX+ splodeMoveAmount, posY - splodeMoveAmount, posX+ splodeMoveAmount*2, posY - splodeMoveAmount*2)
        line(posX- splodeMoveAmount, posY + splodeMoveAmount, posX- splodeMoveAmount*2, posY + splodeMoveAmount*2)
        line(posX- splodeMoveAmount, posY - splodeMoveAmount, posX- splodeMoveAmount*2, posY - splodeMoveAmount*2)*/
        splodeMoveAmount += .2;
        fill(255);
      }
    }
  }

  void update()
  {
    velocityY += gravity;
    posY += velocityY;
    
    if(dir!=2)
      if(velocityY > 12)
        velocityY = 12;
    if (posY > height - 25.0)
    {
      /*posY = height - 25.0;
      velocityY = 0.0;*/
      onGround = true;
    }

    if (posX < 30)
      posX = 30;
    if (posX > width - 30)
      posX = width - 30;
  }

  void render()
  {
    noStroke();
    flame = random(0, 4);
    pushMatrix();
    translate(posX, posY);
    rotate((90.0 * dir)/rad);
    fill(colours[packC].r, colours[packC].b, colours[packC].g);
    rect(0, 2, 25, 20);
    fill(colours[baseC].r, colours[baseC].b, colours[baseC].g);
    rect(0, 0, 20, 20);
    fill(colours[toolC].r, colours[toolC].b, colours[toolC].g);
    if(tool == 0)
    {
      rect(0, -80, 4, -170);
      rect(0, -90, 7, 140);
      rect(0, -22, 20, 3);
      triangle(-7, -150, 7, -150, 0, -170);
      triangle(-7, -150, 7, -150, 0, 0);
    }
    if(tool == 1)
    {
      rect(0, -7, 4, -30);
      triangle(-9, -17, 9, -17, 0, -50);
      triangle(-6, -17, 6, -17, 0, -82);
      triangle(-3, -17, 3, -17, 0, -170);
    }
    if(tool == 2)
    {
      fill(30);
      rect(0, -7, 4, -30);
      fill(colours[toolC].r, colours[toolC].g, colours[toolC].b);
      rect(0, -100, 4, -170);
      fill(colours[toolC].r, colours[toolC].g, colours[toolC].b, 100);
      rect(0, -101, 8, -172);
    }
    /*triangle(-9, -17, 9, -17, 0, -50);
     triangle(-6, -17, 6, -17, 0, -82);
     triangle(-3, -17, 3, -17, 0, -170);*/
    fill(colours[strapC].r, colours[strapC].b, colours[strapC].g);
    rect(-5, 0, 4, 20);
    rect(5, 0, 4, 20);
    fill(colours[buckleC].r, colours[buckleC].b, colours[buckleC].g);
    rect(0, 0, 7, 7);
    fill(colours[flameC].r, colours[flameC].b, colours[flameC].g);
    if(numFlames == 0)
      triangle(0-5-flame, 0+12, 0 + 5 + flame, 0 + 12, 0, 0 + 15+flame);
    if(numFlames == 1)
    {
      triangle(0-7-flame, 0+12, 0 - 2 + flame, 0 + 12, -4.5, 0 + 15+flame);
      triangle(0+7+flame, 0+12, 0 + 2 - flame, 0 + 12, +4.5, 0 + 15+flame);
    }
    popMatrix();
    
    fill(255);
    for(collisionBox c: cboxes)
      c.boxCreation();
  }

  void setCBoxes(ArrayList<collisionBox> boxes)
  {
    cboxes = boxes;
  }
  
  void keyPressed()
  {


    //println(keys);
  }

  void keyReleased()
  {
  }
}



