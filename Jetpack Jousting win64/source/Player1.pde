class Player1
{
  ArrayList<collisionBox> cboxes = new ArrayList<collisionBox>();
  float splodeMoveAmount1 = 0;
  float cWidth = 1280;
  float posX1 = cWidth -100;
  float posY1 = 720-100;
  float velocityX1 = 14.0;
  float velocityY1 = 0.0;
  float gravity1 = .5;
  boolean onGround1 = false;
  boolean shaken = false;
  boolean stunned1 = false;
  boolean stunStart1 = true;
  boolean splode1 = false;
  float stunLength1 = 1.5;
  float millisHold1 = 0;
  float dir1 = 0;
  float rad1 = 57.295;
  float flame1 = 0;
  boolean[] keys1 = new boolean[4];

  
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
  
  int tool = 1; //sword or lance
  int toolC = 6;
  int numFlames = 1;
  int flameC = 0;
  int packC = 2;
  int baseC = 0;
  int strapC = 4;
  int buckleC = 3;

  Player1()
  {
  }

  void startJump1()
  {
    //if (onGround1)
    //{
    velocityY1 = -15.0;
    gravity1 = .01;
    onGround1 = false;
    //}
  }

  void endJump1()
  {
    if (velocityY1 < -6.0)
      velocityY1 = -6.0;
    gravity1 = .2;
  }

  void play1()
  {
    if (!splode1)
    {
      if (keyPressed)
        keyPressed();
      if (!stunned1) {
        if (keys1[0])
        {
          startJump1();
          dir1 = 0;
        }
        if (keys1[1])
        {
          posX1 += abs(velocityX1);
          dir1 = 1;
        }
        if (keys1[3])
        {
          posX1 += abs(velocityX1) * -1;
          dir1 = -1;
        }
        if (keys1[2])
        {
          if (posY1 < height - 30) {
            dir1 = 2;
            velocityY1 +=3;
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
        if(!(posY1< c.y) && posY1 <= c.y + c.h + 100 && dir1 == 0 && posX1 >= c.x && posX1 <= c.x + c.w)
        {
          if (stunStart1)
          {
            stunLength1 = 1.5;
            stunned1 = true;
            millisHold1 = millis();
          }
        }
        /*if(dir1 != 0 && posY1< 30)
          posY1 = 30;*/
        //above
        if(!(posY1 > c.y) && posY1 >= c.y - 100 && dir1 == 2 && posX1 >= c.x && posX1 <= c.x + c.w)
        {
          if (stunStart1)
          {
            stunLength1 = 1.5;
            stunned1 = true;
            millisHold1 = millis();
          }
        }
        
        if(posY1 > c.y && posY1 <= c.y + c.h + 20 && posX1 > c.x && posX1 < c.x + c.w)
        {
          posY1 = c.y + c.h + 20;
        }
        
        if(!(posX1 < c.x) && posX1 <= c.x + c.w + 100 && dir1 == -1 && posY1 >= c.y && posY1 <= c.y + c.h)
        {
          if (stunStart1)
          {
            stunLength1 = 1.5;
            stunned1 = true;
            millisHold1 = millis();
          }
        }
        
        if(!(posX1 > c.x) && posX1 >= c.x - 100 && dir1 == 1 && posY1 >= c.y-5 && posY1 <= c.y + c.h+5)
        {
          if (stunStart1)
          {
            stunLength1 = 1.5;
            stunned1 = true;
            millisHold1 = millis();
          }
        }
        
        if(posX1 >= c.x-10 && posX1 <= c.x + c.w - 10 && posY1 >= c.y && posY1 <= c.y + c.h)
        {
          if(abs(posX1 - c.x) < abs(posX1 - (c.x + c.w)))
          {
            println("posX1: " + posX1 + " " + "c.x: " + c.x + " " + "c.x and c.w: " + (c.w+ c.x));
            posX1 = c.x - 15;
          }
          else
          {
            println("i am unique");
            posX1 = c.x + c.w + 15;
          }
        }
        
        if(posY1 <= c.y + c.h && posY1 >= c.y -13 &&  posX1 >= c.x && posX1 <= c.x + c.w)
        {
          println("helo");
          posY1 = c.y-13;
          /*if(dir1 != 0)
            velocityY = 0;
          else*/
          //bounce
            velocityY1 = -1 * abs(velocityY1);
        }
        
        //left
      }


      /*if (posY1 >= height - 100 && dir1 == 2)
      {
        if (stunStart1)
        {
          stunned1 = true;
          millisHold1 = millis();
        }
      }

      if (posX1 <= 100 && dir1 == -1)
      {
        if (stunStart1)
        {
          stunned1 = true;
          millisHold1 = millis();
        }
      }

      if (posX1 >= width-100 && dir1 == 1)
      {
        if (stunStart1)
        {
          stunned1 = true;
          millisHold1 = millis();
        }
      }*/
      //background(0);
      if (!stunned1) {
        update1();
      }
      else
      {
        if (stunLength1 > 0) 
        {
          stunStart1 = false;
            if(velocityX1 > 0)
              velocityX1 = 0;
            if(velocityY1 > 0)
              velocityY1 = 0;
          if ((millis() - millisHold1) > 500)
          {
            stunLength1-=.5;
            millisHold1 = millis();
          }
          //inCountdown = true;
          fill(255);
          text("P2 stunned for " + stunLength1 + " seconds.", 140, 60);
        }
        else
        {
          if(dir1==2)
            dir1 = 0;
          else if((posX1 < width/2 && posX1 > width/4) || (posX1 > width *3/4))
            dir1 = -1;
          else
            dir1 = 1;
          stunned1 = false;
          velocityX1 = 14;

          stunStart1 = true;
          stunLength1 = 1.5;
        }
      }
      render1();
      keyReleased();
    }
    else
    {
      if (splodeMoveAmount1 <40)
      {
        fill(255, 0, 0);
        ellipse(posX1 - splodeMoveAmount1, posY1, 1 + splodeMoveAmount1, 1 + splodeMoveAmount1);
        ellipse(posX1, posY1 - splodeMoveAmount1, 1 + splodeMoveAmount1, 1 + splodeMoveAmount1);
        ellipse(posX1 + splodeMoveAmount1, posY1, 1 + splodeMoveAmount1, 1 + splodeMoveAmount1);
        ellipse(posX1, posY1 + splodeMoveAmount1, 1 + splodeMoveAmount1, 1 + splodeMoveAmount1);
        ellipse(posX1 + splodeMoveAmount1 / 1.4, posY1 + splodeMoveAmount1 /1.4, 1 + splodeMoveAmount1, 1 + splodeMoveAmount1);
        ellipse(posX1 - splodeMoveAmount1 / 1.4, posY1 + splodeMoveAmount1 /1.4, 1 + splodeMoveAmount1, 1 + splodeMoveAmount1);
        ellipse(posX1 - splodeMoveAmount1 / 1.4, posY1 - splodeMoveAmount1 /1.4, 1 + splodeMoveAmount1, 1 + splodeMoveAmount1);
        ellipse(posX1 + splodeMoveAmount1 / 1.4, posY1 - splodeMoveAmount1 /1.4, 1 + splodeMoveAmount1, 1 + splodeMoveAmount1);
        
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
        translate(posX1, posY1);
        rotate(PI/7);
        for(int i = 0; i < 20; i++)
        {
          rotate(PI/7);
          fill(240, 40 + random(200), 29);
          ellipse(0- random(splodeMoveAmount1), 0, 1 + random(splodeMoveAmount1), 1 + random(splodeMoveAmount1));
          fill(240, 40 + random(200), 29);
          ellipse(0, 0 - random(splodeMoveAmount1), 1 + random(splodeMoveAmount1), 1 + random(splodeMoveAmount1));
          fill(240, 40 + random(200), 29);
          ellipse(0 + random(splodeMoveAmount1), 0, 1 + random(splodeMoveAmount1), 1 + random(splodeMoveAmount1));
          fill(240, 40 + random(200), 29);
          ellipse(0, 0 + random(splodeMoveAmount1), 1 + random(splodeMoveAmount1), 1 + random(splodeMoveAmount1));
          fill(240, 40 + random(200), 29);
          ellipse(0 + random(splodeMoveAmount1) / 1.4, 0 + random(splodeMoveAmount1) /1.4, 1 + random(splodeMoveAmount1), 1 + random(splodeMoveAmount1));
          fill(240, 40 + random(200), 29);
          ellipse(0 - random(splodeMoveAmount1) / 1.4, 0 + random(splodeMoveAmount1) /1.4, 1 + random(splodeMoveAmount1), 1 + random(splodeMoveAmount1));
          fill(240, 40 + random(200), 29);
          ellipse(0 - random(splodeMoveAmount1) / 1.4, 0 - random(splodeMoveAmount1) /1.4, 1 + random(splodeMoveAmount1), 1 + random(splodeMoveAmount1));
          fill(240, 40 + random(200), 29);
          ellipse(0 + random(splodeMoveAmount1) / 1.4, 0 - random(splodeMoveAmount1) /1.4, 1 + random(splodeMoveAmount1), 1 + random(splodeMoveAmount1));
        }
        popMatrix();
        splodeMoveAmount1 += .2;
        fill(255);
      }
    }
  }

  void update1()
  {
    velocityY1 += gravity1;
    posY1 += velocityY1;


      if(dir1!=2)
        if(velocityY1 > 12)
          velocityY1 = 12;

    if (posY1 > height - 25.0)
    {
      /*posY1 = height - 25.0;
      velocityY1 = 0.0;*/
      onGround1 = true;
    }

    if (posX1 < 30)
      posX1 = 30;
    if (posX1 > width - 30)
      posX1 = width - 30;
  }

  void render1()
  {
    noStroke();
    flame1 = random(0, 4);
    pushMatrix();
    translate(posX1, posY1);
    rotate((90.0 * dir1)/rad1);
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
      triangle(0-5-flame1, 0+12, 0 + 5 + flame1, 0 + 12, 0, 0 + 15+flame1);
    if(numFlames == 1)
    {
      triangle(0-7-flame1, 0+12, 0 - 2 + flame1, 0 + 12, -4.5, 0 + 15+flame1);
      triangle(0+7+flame1, 0+12, 0 + 2 - flame1, 0 + 12, +4.5, 0 + 15+flame1);
    }
    popMatrix();
    fill(255);
  }
  
  void setCBoxes(ArrayList<collisionBox> boxes)
  {
    cboxes = boxes;
  }
  
  void setWidth(int w)
  {
    cWidth = w;
    posX1 = cWidth - 100;
  }
  
  void keyPressed()
  {
    //aprintln(keys1);
  }

  void keyReleased()
  {
    //println("yo1");
    //println("yo");
    /*if (keyCode == UP) {
     endJump1();
     keys1[0] = false;
     }
     if (keyCode == RIGHT) {
     keys1[1] = false;
     }
     if (keyCode == LEFT) {
     keys1[2] = false;
     }
     if (keyCode == DOWN) {
     keys1[3] = false;
     }*/
  }
}

