import ddf.minim.spi.*;
import ddf.minim.signals.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.ugens.*;
import ddf.minim.effects.*;
Timer timer;
boolean timerStarted = false;
ArrayList<collisionBox> boxes = new ArrayList<collisionBox>();
Player p1 = new Player();
Player1 p2 = new Player1();
PImage map0;
PImage map1;
PImage map2;
boolean ePlayed = false;

Minim titleMusic;
Minim gameMusic;
Minim bigExplosion;

AudioPlayer tMusic;
AudioPlayer gMusic;
AudioPlayer bExplosion;

boolean musicStarted = false;
boolean stopTitleMusic = false;
boolean startGameMusic = true;

boolean isPlaying = false;
boolean explosion = false;
boolean newRound = false;
boolean customize = false;
boolean nameTrue = false;
boolean name1True = false;
int mapChoice = 0;
boolean mapSelect = false;
int y = 0, yTotal = 0;
boolean p1win, p2win;
int p1wins = 0, p2wins = 0;
int p1sets = 0, p2sets = 0;
int numRounds = 3;
float millisHoldRound = 0;
float millisHoldMatch = 0;
float millisHoldName = 0;
int matchTime = 21;
int timeToNewRound = 4;
int backgroundC = 0;
float rotation = 0;
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
  String name = "Player 1";
String name1 = "Player 2";


BufferedReader reader;
String line;
String file;
boolean doneOnce = false;

PrintWriter output;

void setup()
{
  size(displayWidth, displayHeight);
  fill(255);
  if (frame != null) {
    frame.setResizable(true);
  }
  noStroke();
  //reader = createReader("profiles.txt");  
  rectMode(CENTER);
  boxes.add(new collisionBox(0, height-15, width, 15));
  boxes.add(new collisionBox(0, 0, 15, height));
  boxes.add(new collisionBox(width-15, 0, 15, height));
  //boxes.add(new collisionBox(width/2-100, height/2-100, 200, 200));
  boxes.add(new collisionBox(0, 0, width, 15));
  titleMusic = new Minim(this);
  gameMusic = new Minim(this);
  bigExplosion = new Minim(this);
  p1.setCBoxes(boxes);
  p2.setCBoxes(boxes);
  tMusic = titleMusic.loadFile("TitleScreenMusic.wav");
  gMusic = gameMusic.loadFile("GameMusic.wav");
  bExplosion = bigExplosion.loadFile("explosion.wav");
  map0 = loadImage("map no square.png");
  map1 = loadImage("map w square.png");
  map2 = loadImage("map pillars.png");
  p2.setWidth(displayWidth);
  println(displayWidth);
}
void stop()
{
  /*// always close Minim audio classes when you are done with them
   if ( gMusic != null )
   {
   gMusic.close();
   }
   if ( tMusic != null )
   {
   tMusic.close();
   }
   titleMusic.stop();
   gameMusic.stop();
   
   super.stop();*/
}

void draw()
{
  tMusic.setGain(-10);
  gMusic.setGain(-10);
  if (!isPlaying && !musicStarted)
  {
    tMusic.play();
    tMusic.loop();
    musicStarted = true;
  }

  if (stopTitleMusic && !startGameMusic)
  {
    tMusic.pause();
    gMusic.play();
    gMusic.loop();
    startGameMusic = true;
  }


  if (customize)
  {
    background(255);


    //readfromfile
    /*  try 
     {
     line = reader.readLine();
     } 
     catch (IOException e) 
     {
     e.printStackTrace();
     line = null;
     } 
     
     if (line == null && !doneOnce) 
     {
     // Stop reading because of an error or file is empty
     file = file.substring(4);
     println(file);
     output = createWriter("profiles.txt"); 
     output.println(file);
     doneOnce = true;
     } 
     else 
     {
     file += line + "\n";
     println(file);
     }
     
     fill(100);
     rect(width/2, height/2 - 100, 50, 50);*/
    //endreadfromfile

    fill(255);
    if (nameTrue || name1True)
    {
      fill(220);
    } else
      fill(255);
    rectMode(CORNER);
    if (nameTrue){
      rect(45, 20, 600, 85);
    }
    if (name1True){
      rect(45, 20 + height/2, 600, 85);
    }
    rectMode(CENTER);
    fill(0);
    rect(width - 200, height/2, 400, height);
    textSize(64);
    strokeWeight(5);
    stroke(128);
    fill(128);
    text(name, 50, 100);

    //to menu
    pushStyle();
    rectMode(CORNER);
    noFill();
    strokeWeight(2);
    rect(width - 51, 5, 45, 45);
    ellipse(width - 28, 28, 15, 15);
    line(width-28, 15, width - 28, 25);
    popStyle();

    strokeWeight(2);
    //options
    textSize(24);
    text("Weapon Type", 65, 150);
    text("Weapon Colour", 65, 180);
    text("Number of Flames", 65, 210);
    text("Flame Colour", 65, 240);
    text("Thruster Colour", 400, 150);
    text("Base Colour", 400, 180.0);
    text("Strap Colour", 400, 210);
    text("Buckle Colour", 400, 240);
    pushMatrix();
    noFill();
    translate(0, 16);
    rect(300, 126, 24, 24);
    rect(300, 156, 24, 24);
    rect(300, 186, 24, 24);
    rect(300, 216, 24, 24);
    rect(625, 126, 24, 24);
    rect(625, 156, 24, 24);
    rect(625, 186, 24, 24);
    rect(625, 216, 24, 24);
    popMatrix();

    pushMatrix();
    noFill();
    translate(30, 16);
    rect(300, 126, 24, 24);
    rect(300, 156, 24, 24);
    rect(300, 186, 24, 24);
    rect(300, 216, 24, 24);
    rect(625, 126, 24, 24);
    rect(625, 156, 24, 24);
    rect(625, 186, 24, 24);
    rect(625, 216, 24, 24);
    popMatrix();
    pushMatrix();
    translate(0, height/2);

    text("Weapon Type", 65, 150);
    text("Weapon Colour", 65, 180);
    text("Number of Flames", 65, 210);
    text("Flame Colour", 65, 240);
    text("Thruster Colour", 400, 150);
    text("Base Colour", 400, 180.0);
    text("Strap Colour", 400, 210);
    text("Buckle Colour", 400, 240);

    pushMatrix();
    noFill();
    translate(0, 16);
    rect(300, 126, 24, 24);
    rect(300, 156, 24, 24);
    rect(300, 186, 24, 24);
    rect(300, 216, 24, 24);
    rect(625, 126, 24, 24);
    rect(625, 156, 24, 24);
    rect(625, 186, 24, 24);
    rect(625, 216, 24, 24);
    popMatrix();

    pushMatrix();
    noFill();
    translate(30, 16);
    rect(300, 126, 24, 24);
    rect(300, 156, 24, 24);
    rect(300, 186, 24, 24);
    rect(300, 216, 24, 24);
    rect(625, 126, 24, 24);
    rect(625, 156, 24, 24);
    rect(625, 186, 24, 24);
    rect(625, 216, 24, 24);
    popMatrix();
    popMatrix();


    //optionsend
    textSize(64);

    text(name1, 50, height/2 +100);
    line(0, height/2, width, height/2);
    strokeWeight(3);
    line(45, 105, 645, 105);
    line(45, height/2 + 105, 645, height/2 + 105);

    noStroke();
    float flame = random(0, 4);
    pushMatrix();
    translate(width-200, height/4);
    rotate(rotation);
    rotation += .01;
    fill(colours[p1.packC].r, colours[p1.packC].b, colours[p1.packC].g);
    rect(0, 2, 25, 20);
    fill(colours[p1.baseC].r, colours[p1.baseC].b, colours[p1.baseC].g);
    rect(0, 0, 20, 20);
    fill(colours[p1.toolC].r, colours[p1.toolC].b, colours[p1.toolC].g);
    if (p1.tool == 0)
    {
      rect(0, -80, 4, -170);
      rect(0, -90, 7, 140);
      rect(0, -22, 20, 3);
      triangle(-7, -150, 7, -150, 0, -170);
      triangle(-7, -150, 7, -150, 0, 0);
    }
    if (p1.tool == 1)
    {
      rect(0, -7, 4, -30);
      triangle(-9, -17, 9, -17, 0, -50);
      triangle(-6, -17, 6, -17, 0, -82);
      triangle(-3, -17, 3, -17, 0, -170);
    }
    if (p1.tool == 2)
    {
      fill(30);
      rect(0, -7, 4, -30);
      fill(colours[p1.toolC].r, colours[p1.toolC].g, colours[p1.toolC].b);
      rect(0, -100, 4, -170);
      fill(colours[p1.toolC].r, colours[p1.toolC].g, colours[p1.toolC].b, 100);
      rect(0, -101, 8, -172);
    }
    /*triangle(-9, -17, 9, -17, 0, -50);
     triangle(-6, -17, 6, -17, 0, -82);
     triangle(-3, -17, 3, -17, 0, -170);*/
    fill(colours[p1.strapC].r, colours[p1.strapC].b, colours[p1.strapC].g);
    rect(-5, 0, 4, 20);
    rect(5, 0, 4, 20);
    fill(colours[p1.buckleC].r, colours[p1.buckleC].b, colours[p1.buckleC].g);
    rect(0, 0, 7, 7);
    fill(colours[p1.flameC].r, colours[p1.flameC].b, colours[p1.flameC].g);
    if (p1.numFlames == 0)
      triangle(0-5-flame, 0+12, 0 + 5 + flame, 0 + 12, 0, 0 + 15+flame);
    if (p1.numFlames == 1)
    {
      triangle(0-7-flame, 0+12, 0 - 2 + flame, 0 + 12, -4.5, 0 + 15+flame);
      triangle(0+7+flame, 0+12, 0 + 2 - flame, 0 + 12, +4.5, 0 + 15+flame);
    }
    popMatrix();

    noStroke();
    flame = random(0, 4);
    pushMatrix();
    translate(width-200, 3*height/4);
    rotate(rotation);
    fill(colours[p2.packC].r, colours[p2.packC].b, colours[p2.packC].g);
    rect(0, 2, 25, 20);
    fill(colours[p2.baseC].r, colours[p2.baseC].b, colours[p2.baseC].g);
    rect(0, 0, 20, 20);
    fill(colours[p2.toolC].r, colours[p2.toolC].b, colours[p2.toolC].g);
    if (p2.tool == 0)
    {
      rect(0, -80, 4, -170);
      rect(0, -90, 7, 140);
      rect(0, -22, 20, 3);
      triangle(-7, -150, 7, -150, 0, -170);
      triangle(-7, -150, 7, -150, 0, 0);
    }
    if (p2.tool == 1)
    {
      rect(0, -7, 4, -30);
      triangle(-9, -17, 9, -17, 0, -50);
      triangle(-6, -17, 6, -17, 0, -82);
      triangle(-3, -17, 3, -17, 0, -170);
    }
    if (p2.tool == 2)
    {
      fill(30);
      rect(0, -7, 4, -30);
      fill(colours[p2.toolC].r, colours[p2.toolC].g, colours[p2.toolC].b);
      rect(0, -100, 4, -170);
      fill(colours[p2.toolC].r, colours[p2.toolC].g, colours[p2.toolC].b, 100);
      rect(0, -101, 8, -172);
    }
    fill(colours[p2.strapC].r, colours[p2.strapC].b, colours[p2.strapC].g);
    rect(-5, 0, 4, 20);
    rect(5, 0, 4, 20);
    fill(colours[p2.buckleC].r, colours[p2.buckleC].b, colours[p2.buckleC].g);
    rect(0, 0, 7, 7);
    fill(colours[p2.flameC].r, colours[p2.flameC].b, colours[p2.flameC].g);
    if (p2.numFlames == 0)
      triangle(0-5-flame, 0+12, 0 + 5 + flame, 0 + 12, 0, 0 + 15+flame);
    if (p2.numFlames == 1)
    {
      triangle(0-7-flame, 0+12, 0 - 2 + flame, 0 + 12, -4.5, 0 + 15+flame);
      triangle(0+7+flame, 0+12, 0 + 2 - flame, 0 + 12, +4.5, 0 + 15+flame);
    }
    popMatrix();
  } else if (mapSelect)
  {
    background(0);
    textSize(64);
    textAlign(CENTER);
    fill(255);
    text("Choose your map!", width/2, 100);
    image(map0, 100, 600, 250, 144);
    image(map1, width - 350, 600, 250, 144);
    image(map2, width/2 - 125, 600, 250, 144);
  } else if (isPlaying && !(p1wins == numRounds || p2wins == numRounds))
  {
    if (backgroundC != 0)
      backgroundC -=2;
    background(0);
    for (int i = 0; i < 50; i++)
      ellipse(random(width), random(height), 3, 3);
    for (int i = 1; i <=numRounds; i++)
    {
      stroke(255);
      if (p1wins >= i)
        fill(255, 0, 0);
      else
        fill(0);
      ellipse(width/3 + i*10, 75, 10, 10);
      if (p2wins >= i)
        fill(255, 0, 0);
      else
        fill(0);
      ellipse(2*width/3 + i*10 - 12 * numRounds, 75, 10, 10);
      noStroke();
    }
    pushMatrix();
    //translate(0, y);
    //keyPressed();
    /*if(p1.posY < 200 && p2.posY1 < 200)
     {
     if(p1.posY < -720)
     {
     y++;
     println("up");
     }
     else
     {
     y--; 
     println("down");
     }
     if(y < -720)
     {
     y = 0;
     println("resetup");
     }
     if(y > 0)
     {
     translate(0, abs(y));
     println("resetdown");
     y=0;
     }
     }
     println(p1.posY);*/
    textSize(16);
    fill(255);
    if (newRound)
    {
      textSize(64);
      textAlign(CENTER);
      text("GET READY!", width/2, height/2 - 100);
      textSize(128);
      text(timeToNewRound, width/2, height/2 + 200);
      if (millisHoldRound +1000 < millis())
      {
        millisHoldRound = millis();
        timeToNewRound--;
      }
      if (timeToNewRound == 0)
      {
        newRound = false;
        p1.dir = 0;
        p2.dir1 = 0;
        /*p1.stunLength = 1.5;
         p2.stunLength1 = 1.5;
         p1.stunned = true;
         p2.stunned1 = true;*/
        timeToNewRound = 4;
        matchTime = 21;
      }
      fill(120, 120, 120, 120);
      rect(0, 0, 10000, 10000);
      ePlayed = false;
      bExplosion.pause();
      bExplosion.rewind();
    } else
    {
      textSize(32);
      text(name, width  * 25/72, 50);
      text(name1, width * 47/72, 50);
      textSize(64);
      text(matchTime, width/2, 100);
      if (millisHoldMatch +1000 < millis())
      {
        millisHoldMatch = millis();
        if (!p1win && !p2win && !explosion)
          matchTime--;
      }
      if (matchTime == 0 && !p1win && !p2win)
      {
        matchTime = 0;
        if (p1.posY > p2.posY1)
        {
          p1win = true;
          p1wins++;
        } else
        { 
          p2win = true;
          p2wins++;
        }
      }
      textSize(16);
      p2.play1();
      p1.play();
      textSize(32);
      if (handleUnitCollision())
      {
        backgroundC = 150;
      }
      fill(255);
      /*rect(width/2, height-5, width, 15);
       rect(0, height/2, 20, height);
       rect(width, height/2, 20, height);*/
      if (p1win)
      {
        textSize(48);
        text(name + " wins", width/2, 240);
        textSize(32);
        text("Press Spacebar to continue", width/2, 540);
        if (!ePlayed)
        {
          bExplosion.play();
          ePlayed = true;
        }
      }
      if (p2win)
      {
        textSize(48);
        text(name1 + " wins", width/2, 240);
        textSize(32);
        text("Press Spacebar to continue", width/2, 540);
        if (!ePlayed)
        {
          bExplosion.play();
          ePlayed = true;
        }
      }
      if (explosion)
      {
        text("Congratulations - you are both losers", width/2, 250);
        textSize(32);
        text("Press Spacebar to continue", width/2, 540);
        if (!ePlayed)
        {
          bExplosion.play();
          ePlayed = true;
        }
      }
    }
    popMatrix();
  } else if (p1wins == numRounds || p2wins == numRounds)
  {
    /*if(!timerStarted)
     {
     timer = new Timer(3);
     timerStarted = true;
     }*/
    background(255);
    fill(0);
    textSize(64);
    if (p1wins == numRounds)
    {
      text(name + " wins it all!", width/2, height/2);
    }
    if (p2wins == numRounds)
    {
      text(name1 + " wins it all!", width/2, height/2);
    }
  } else
  {
    textAlign(CORNER);
    strokeWeight(1);
    //title screen
    background(255);
    //jetpack
    float flame = random(0, 4);
    pushMatrix();
    translate(1000, 600);
    fill(100);
    rect(0, 2, 25, 20);
    fill(255);
    rect(0, 0, 20, 20);
    fill(#FFCF1F);
    /*rect(0, -80, 4, -170);
     rect(0, -90, 7, 140);
     rect(0, -22, 20, 3);
     triangle(-7, -150, 7, -150, 0, -170);
     triangle(-7, -150, 7, -150, 0, 0);
                                        /*triangle(-9, -17, 9, -17, 0, -50);
     triangle(-6, -17, 6, -17, 0, -82);
     triangle(-3, -17, 3, -17, 0, -170);*/
    fill(100);
    rect(-5, 0, 4, 20);
    rect(5, 0, 4, 20);
    fill(0);
    rect(0, 0, 7, 7);
    fill(250, 0, 0);
    triangle(0-5-flame, 0+12, 0 + 5 + flame, 0 + 12, 0, 0 + 15+flame);
    popMatrix();
    //endjetpack
    textSize(64);
    fill(128);
    text("Jetpack Jousting!", width/2 - 275, height/3);
    textSize(32);
    if (p1sets != 0 || p2sets != 0)
    {
      text(name + ": " + p1sets, 100, 50);
      text(name1 + ": " + p2sets, width - 350, 50);
    }
    if (!(mouseX > (width/2.3) - 60 && mouseX < (width/1.7) + 5 && mouseY < height/2+30 && mouseY > height/2 - 50))
      noFill();
    else
      fill(200);
    stroke(128);
    rectMode(CORNER);
    //play button
    rect(width/2.3 - 60, height/2 - 50, 260, 80);
    //num rounds options
    textSize(16);
    fill(255);
    rect(50, height/2 - 42.5, 25, 25);
    rect(50, height/2 - 12.5, 25, 25);
    rect(50, height/2 + 17.5, 25, 25);
    fill(128);
    text("Three rounds.", 80, height/2 - 22.5);
    text("Five rounds.", 80, height/2 + 7.5);
    text("Seven rounds.", 80, height/2 + 37.5);

    if (numRounds == 3)
    {
      line(52.5, height/2 - 40, 72.5, height/2 - 20);
      line(52.5, height/2 - 20, 72.5, height/2 - 40);
    }
    if (numRounds == 5)
    {
      line(52.5, height/2 - 10, 72.5, height/2 + 10);
      line(52.5, height/2 + 10, 72.5, height/2 - 10);
    }
    if (numRounds == 7)
    {
      line(52.5, height/2 + 20, 72.5, height/2 + 40);
      line(52.5, height/2 + 40, 72.5, height/2 + 20);
    }

    if (!(mouseX > (width/2.3) - 60 && mouseX < (width/1.7) + 5 && mouseY < height/2+180 && mouseY > height/2 +100))
      noFill();
    else
      fill(200);
    rect(width/2.3 - 60, height/2 + 100, 260, 80);

    rectMode(CENTER);
    textSize(32);
    fill(128);
    text("Play now!", width/2.3, height/2);
    text("Customize!", width/2.3-20, height/2+ 150);
    textSize(16);
    noStroke();
  }

  //keyReleased();
}


void keyPressed()
{
  if (keyCode == ESC)
  {
    /*output.flush();
     output.close();*/
    exit();
  }
  if (customize)
  {
    if (keyCode == ENTER)
    {
      name1True = false;
      nameTrue = false;
    }
    if (name1True)
    {
      if (name1.length() != 0)
        if (keyCode == BACKSPACE)
          name1 = name1.substring(0, name1.length() - 1);
      if (name1.length() < 12)
      {
        if (key == ' ')
          name1 += ' ';
        if (key == 'a')
          name1 += 'a';
        if (key == 'b')
          name1 += 'b';
        if (key == 'c')
          name1 += 'c';
        if (key == 'd')
          name1 += 'd';
        if (key == 'e')
          name1 += 'e';
        if (key == 'f')
          name1 += 'f';
        if (key == 'g')
          name1 += 'g';
        if (key == 'h')
          name1 += 'h';
        if (key == 'i')
          name1 += 'i';
        if (key == 'j')
          name1 += 'j';
        if (key == 'k')
          name1 += 'k';
        if (key == 'l')
          name1 += 'l';
        if (key == 'm')
          name1 += 'm';
        if (key == 'n')
          name1 += 'n';
        if (key == 'o')
          name1 += 'o';
        if (key == 'p')
          name1 += 'p';
        if (key == 'q')
          name1 += 'q';
        if (key == 'r')
          name1 += 'r';
        if (key == 's')
          name1 += 's';
        if (key == 't')
          name1 += 't';
        if (key == 'u')
          name1 += 'u';
        if (key == 'v')
          name1 += 'v';
        if (key == 'w')
          name1 += 'w';
        if (key == 'x')
          name1 += 'x';
        if (key == 'y')
          name1 += 'y';
        if (key == 'z')
          name1 += 'z';

        if (key == 'A')
          name1 += 'A';
        if (key == 'B')
          name1 += 'B';
        if (key == 'C')
          name1 += 'C';
        if (key == 'D')
          name1 += 'D';
        if (key == 'E')
          name1 += 'E';
        if (key == 'F')
          name1 += 'F';
        if (key == 'G')
          name1 += 'G';
        if (key == 'H')
          name1 += 'H';
        if (key == 'I')
          name1 += 'I';
        if (key == 'J')
          name1 += 'J';
        if (key == 'K')
          name1 += 'K';
        if (key == 'L')
          name1 += 'L';
        if (key == 'M')
          name1 += 'M';
        if (key == 'N')
          name1 += 'N';
        if (key == 'O')
          name1 += 'O';
        if (key == 'P')
          name1 += 'P';
        if (key == 'Q')
          name1 += 'Q';
        if (key == 'R')
          name1 += 'R';
        if (key == 'S')
          name1 += 'S';
        if (key == 'T')
          name1 += 'T';
        if (key == 'U')
          name1 += 'U';
        if (key == 'V')
          name1 += 'V';
        if (key == 'W')
          name1 += 'W';
        if (key == 'X')
          name1 += 'X';
        if (key == 'Y')
          name1 += 'Y';
        if (key == 'Z')
          name1 += 'Z';
        if (key == '1')
          name1 += '1';
        if (key == '2')
          name1 += '2';
        if (key == '3')
          name1 += '3';
        if (key == '4')
          name1 += '4';
        if (key == '5')
          name1 += '5';
        if (key == '6')
          name1 += '6';
        if (key == '7')
          name1 += '7';
        if (key == '8')
          name1 += '8';
        if (key == '9')
          name1 += '9';
        if (key == '0')
          name1 += '0';
      }
    }
    if (nameTrue)
    {
      if (name.length() != 0)
        if (keyCode == BACKSPACE)
          name = name.substring(0, name.length() - 1);
      if (name.length() < 12)
      {
        if (key == ' ')
          name += ' ';
        if (key == 'a')
          name += 'a';
        if (key == 'b')
          name += 'b';
        if (key == 'c')
          name += 'c';
        if (key == 'd')
          name += 'd';
        if (key == 'e')
          name += 'e';
        if (key == 'f')
          name += 'f';
        if (key == 'g')
          name += 'g';
        if (key == 'h')
          name += 'h';
        if (key == 'i')
          name += 'i';
        if (key == 'j')
          name += 'j';
        if (key == 'k')
          name += 'k';
        if (key == 'l')
          name += 'l';
        if (key == 'm')
          name += 'm';
        if (key == 'n')
          name += 'n';
        if (key == 'o')
          name += 'o';
        if (key == 'p')
          name += 'p';
        if (key == 'q')
          name += 'q';
        if (key == 'r')
          name += 'r';
        if (key == 's')
          name += 's';
        if (key == 't')
          name += 't';
        if (key == 'u')
          name += 'u';
        if (key == 'v')
          name += 'v';
        if (key == 'w')
          name += 'w';
        if (key == 'x')
          name += 'x';
        if (key == 'y')
          name += 'y';
        if (key == 'z')
          name += 'z';

        if (key == 'A')
          name += 'A';
        if (key == 'B')
          name += 'B';
        if (key == 'C')
          name += 'C';
        if (key == 'D')
          name += 'D';
        if (key == 'E')
          name += 'E';
        if (key == 'F')
          name += 'F';
        if (key == 'G')
          name += 'G';
        if (key == 'H')
          name += 'H';
        if (key == 'I')
          name += 'I';
        if (key == 'J')
          name += 'J';
        if (key == 'K')
          name += 'K';
        if (key == 'L')
          name += 'L';
        if (key == 'M')
          name += 'M';
        if (key == 'N')
          name += 'N';
        if (key == 'O')
          name += 'O';
        if (key == 'P')
          name += 'P';
        if (key == 'Q')
          name += 'Q';
        if (key == 'R')
          name += 'R';
        if (key == 'S')
          name += 'S';
        if (key == 'T')
          name += 'T';
        if (key == 'U')
          name += 'U';
        if (key == 'V')
          name += 'V';
        if (key == 'W')
          name += 'W';
        if (key == 'X')
          name += 'X';
        if (key == 'Y')
          name += 'Y';
        if (key == 'Z')
          name += 'Z';
        if (key == '1')
          name += '1';
        if (key == '2')
          name += '2';
        if (key == '3')
          name += '3';
        if (key == '4')
          name += '4';
        if (key == '5')
          name += '5';
        if (key == '6')
          name += '6';
        if (key == '7')
          name += '7';
        if (key == '8')
          name += '8';
        if (key == '9')
          name += '9';
        if (key == '0')
          name += '0';
      }
    }
  }
  //println("pressed");
  if (p1win || p2win || explosion)
    if (key == ' ')
    {
      if (p1wins == numRounds || p2wins == numRounds)
      {
        if (p1wins == numRounds)
          p1sets++;
        if (p2wins == numRounds)
          p2sets++;
        isPlaying = false;
        tMusic.rewind();
        gMusic.pause();
        tMusic.play();
        tMusic.loop();
        startGameMusic = true;
        gMusic.rewind();
        p1wins = 0;
        p2wins = 0;
      }
      newRound = true;
      p1win = false;
      p2win = false;
      explosion = false;
      p1.posX = 100;
      p2.posX1 = width-100;
      p1.posY = p2.posY1 = height-100;
      p1.dir = p2.dir1 = 2;
      p1.splode = p2.splode1 = false;
      p1.splodeMoveAmount = p2.splodeMoveAmount1 = 0;
    }

  if (!p1.stunned)
  {
    if (key == 'w') {
      p1.keys[0] = true;
    }
    if (key == 'd') {
      p1.keys[1] = true;
    }
    if (key == 'a') {
      p1.keys[3] = true;
    }
    if (key == 's') {
      p1.keys[2] = true;
    }
  }
  if (!p2.stunned1)
  {
    if (key == 'i') {
      p2.keys1[0] = true;
    }
    if (key == 'l') {
      p2.keys1[1] = true;
    }
    if (key == 'j') {
      p2.keys1[3] = true;
    }
    if (key == 'k') {
      p2.keys1[2] = true;
    }
  }
  if (!p2.stunned1)
  {
    if (keyCode == UP) {
      p2.keys1[0] = true;
    }
    if (keyCode == RIGHT) {
      p2.keys1[1] = true;
    }
    if (keyCode == LEFT) {
      p2.keys1[3] = true;
    }
    if (keyCode == DOWN) {
      p2.keys1[2] = true;
    }
  }
}
//println(p1.keys);


void keyReleased()
{
  //println("released");

  if (key == 'i') {
    p2.endJump1();
    p2.keys1[0] = false;
  }
  if (key == 'l') {
    p2.keys1[1] = false;
  }
  if (key == 'j') {
    p2.keys1[3] = false;
  }
  if (key == 'k') {
    p2.keys1[2] = false;
  }
  if (keyCode == UP) {
    p2.endJump1();
    p2.keys1[0] = false;
  }
  if (keyCode == RIGHT) {
    p2.keys1[1] = false;
  }
  if (keyCode == LEFT) {
    p2.keys1[3] = false;
  }
  if (keyCode == DOWN) {
    p2.keys1[2] = false;
  }

  if (key == 'w') {
    p1.endJump();
    p1.keys[0] = false;
  }
  if (key == 'd') {
    p1.keys[1] = false;
  }
  if (key == 'a') {
    p1.keys[3] = false;
  }
  if (key == 's') {
    p1.keys[2] = false;
  }
}

boolean handleUnitCollision()
{
  if (!explosion && !p1win && !p2win)
  {
    if (abs(p1.posY - p2.posY1) <= 25)
    {
      //p1 right p2
      if (p1.dir == 1 && p1.posX - p2.posX1 >-170 && p1.posX - p2.posX1 <0)
      {
        //println(p1.posX - p2.posX1);
        if (p2.dir1 == -1)
        {
          p1.splode = true;
          p2.splode1 = true;
          explosion = true;
          return true;
        } else
        {
          p2.splode1 = true;   
          p1win = true;
          p1wins++;
          return true;
        }
      }

      //p1 left p2
      if (p1.dir == -1 && p1.posX - p2.posX1 <170 && p1.posX - p2.posX1 >0)
      {
        //println(p1.posX - p2.posX1);
        if (p2.dir1 == 1)
        {
          p1.splode = true;
          p2.splode1 = true;
          explosion = true;
          return true;
        } else
        {
          p2.splode1 = true;
          p1win = true;
          p1wins++;
          return true;
        }
      }

      //p2 right p1
      if (p2.dir1 == 1 && p2.posX1 - p1.posX > -170 && p2.posX1 - p1.posX < 0)
      {
        if (p1.dir == -1)
        {
          p1.splode = true;
          p2.splode1 = true;
          explosion = true;
          return true;
        } else
        {
          p1.splode = true;
          p2win = true;
          p2wins++;
          return true;
        }
      }

      //p2 left p1
      if (p2.dir1 == -1 && p2.posX1 - p1.posX < 170 && p2.posX1 - p1.posX > 0)
      {
        if (p1.dir == 1)
        {
          p1.splode = true;
          p2.splode1 = true;
          explosion = true;
          return true;
        } else
        {
          p1.splode = true;
          p2win = true;
          p2wins++;
          return true;
        }
      }
    }

    if (abs(p1.posX - p2.posX1) <= 25)
    {
      //p1 up p2
      if (p1.dir == 2 && p1.posY - p2.posY1 > -170 && p1.posY - p2.posY1 < 0)
      {
        if (p2.dir1 == 0)
        {
          p1.splode = true;
          p2.splode1 = true;
          explosion = true;
          return true;
        } else
        {
          p2.splode1 = true;
          p1win = true;
          p1wins++;
          return true;
        }
      }

      //p1 down p2
      if (p1.dir == 0 && p1.posY - p2.posY1 < 170 && p1.posY - p2.posY1 > 0)
      {
        if (p2.dir1 == 2)
        {
          p1.splode = true;
          p2.splode1 = true;
          explosion = true;
          return true;
        } else
        {
          p2.splode1 = true;
          p1win = true;
          p1wins++;
          return true;
        }
      }

      //p2 down p1
      if (p2.dir1 == 0 && p2.posY1 - p1.posY < 170 && p2.posY1 - p1.posY > 0)
      {
        if (p1.dir == 2)
        {
          p1.splode = true;
          p2.splode1 = true;
          explosion = true;
          return true;
        } else
        {
          p1.splode = true;
          p2win = true;
          p2wins++;
          return true;
        }
      }

      //p2 up p1
      if (p2.dir1 == 2 && p2.posY1 - p1.posY > -170 && p2.posY1 - p1.posY < 0)
      {
        if (p1.dir == 0)
        {
          p1.splode = true;
          p2.splode1 = true;
          explosion = true;
          return true;
        } else
        {
          p1.splode = true;
          p2win = true;
          p2wins++;
          return true;
        }
      }
    }
  }
  return false;
}
/*if (dist(p1.posX, p1.posY, p2.posX1, p2.posY1) <= 170)
 {
 println(dist(p1.posX, p1.posY, p2.posX1, p2.posY1));
 if (abs(p1.posY - p2.posY1) <= 25)
 {
 if (p1.dir == 1)
 {
 if (p2.dir1 == -1)
 explosion = true;
 }
 if (p2.dir1 == 1)
 {
 if (p1.dir == -1)
 explosion = true;
 }
 }
 if (abs(p1.posX - p2.posX1) <= 25)
 {
 if (p1.dir == 0)
 {
 if (p2.dir1 == 2)
 explosion = true;
 else
 p1win=true;
 }
 if (p2.dir1 == 0)
 {
 if (p1.dir == 2)
 explosion = true;
 else
 p2win = true;
 }
 }
 }*/
void mouseClicked()
{
  if (!isPlaying)
  {
    if (mouseX > (width/2.3) - 60 && mouseX < (width/1.7) + 5 && mouseY < height/2+30 && mouseY > height/2 - 50)
    { 
      //isPlaying = true;
      mapSelect = true;
      //newRound = true;
    }
    if (!mapSelect)
      if (mouseX > (width/2.3) - 60 && mouseX < (width/1.7) + 5 && mouseY < height/2+180 && mouseY > height/2 +100)
        customize = true;
    if (mapSelect)
    {
      if (mouseX > 100 && mouseX < 350 && mouseY > 600 && mouseY < 744)
      {
        boxes = new ArrayList<collisionBox>();
        boxes.add(new collisionBox(0, height-15, width, 15));
        boxes.add(new collisionBox(0, 0, 15, height));
        boxes.add(new collisionBox(width-15, 0, 15, height));
        boxes.add(new collisionBox(0, 0, width, 15));
        p1.setCBoxes(boxes);
        p2.setCBoxes(boxes);
        mapSelect = false;
        isPlaying = true;
        musicStarted = true;
        stopTitleMusic = true;
        startGameMusic = false;
        newRound = true;
      }
      if (mouseX > width/2 - 125 && mouseX < width/2 + 125 && mouseY > 600 && mouseY < 744)
      {
        boxes = new ArrayList<collisionBox>();
        boxes.add(new collisionBox(0, height-15, width, 15));
        boxes.add(new collisionBox(0, 0, 15, height));
        boxes.add(new collisionBox(width-15, 0, 15, height));
        boxes.add(new collisionBox(width/4, height/3, 30, height/3));
        boxes.add(new collisionBox(width*3/4 - 30, height/3, 30, height/3));
        boxes.add(new collisionBox(0, 0, width, 15));
        p1.setCBoxes(boxes);
        p2.setCBoxes(boxes);
        mapSelect = false;
        isPlaying = true;
        musicStarted = true;
        stopTitleMusic = true;
        startGameMusic = false;
        newRound = true;
      }
      if (mouseX > width - 350 && mouseX < width -100 && mouseY > 600 && mouseY < 744)
      {
        boxes = new ArrayList<collisionBox>();
        boxes.add(new collisionBox(0, height-15, width, 15));
        boxes.add(new collisionBox(0, 0, 15, height));
        boxes.add(new collisionBox(width-15, 0, 15, height));
        boxes.add(new collisionBox(width/2-100, height/2-100, 200, 200));
        boxes.add(new collisionBox(0, 0, width, 15));
        p1.setCBoxes(boxes);
        p2.setCBoxes(boxes);
        mapSelect = false;
        isPlaying = true;
        musicStarted = true;
        stopTitleMusic = true;
        startGameMusic = false;
        newRound = true;
      }
    }
  }
  if (p1wins < 1 && p2wins < 1)
  {
    if (mouseX >= 50 && mouseX <= 75)
    {
      if (mouseY >= height/2 - 42.5 && mouseY <= height/2 - 17.5)
        numRounds = 3;
      if (mouseY >= height/2 - 12.5 && mouseY <= height/2 + 12.5)
        numRounds = 5;
      if (mouseY >= height/2 + 17.5 && mouseY <= height/2 + 42.5)
        numRounds = 7;
    }
  }

  if (customize)
  {
    /*line(45, 105, 45 + name.length() * 31, 105);
     line(45, height/2 + 105, name1.length() * 31, height/2 + 105);*/
    if (mouseX>45 && mouseX< 645 && mouseY > 20 && mouseY < 100)
    {
      name = "";
      nameTrue = true;
    }
    else
      nameTrue = false;
    if (mouseX>45 && mouseX< 645 && mouseY > 20 + height/2 && mouseY < 100 + height/2)
    {
      name1 = "";
      name1True = true;
    }
    else
      name1True = false;
    if (mouseX > width - 51 && mouseX < width-6 && mouseY > 5 && mouseY < 51)
      customize = false;
    println("a");
    println(mouseX + " " + mouseY);
    if (mouseX > 290 && mouseX < 314 && mouseY < 154 && mouseY > 130)
    {
      p1.tool--;
      if (p1.tool < 0)
        p1.tool = 2;
    }
    if (mouseX > 320 && mouseX < 344 && mouseY < 154 && mouseY > 130)
    {
      p1.tool++;
      if (p1.tool > 2)
        p1.tool = 0;
    }

    if (mouseX > 290 && mouseX < 314 && mouseY < 184 && mouseY > 160)
    {
      p1.toolC--;
      if (p1.toolC < 0)
        p1.toolC = colours.length -1;
      println(colours[p1.toolC]);
    }
    if (mouseX > 320 && mouseX < 344 && mouseY < 184 && mouseY > 160)
    {
      p1.toolC++;
      if (p1.toolC > colours.length -1)
        p1.toolC = 0;
      println(colours[p1.toolC]);
    }

    if (mouseX > 290 && mouseX < 314 && mouseY < 214 && mouseY > 190)
    {
      p1.numFlames--;
      if (p1.numFlames < 0)
        p1.numFlames = 1;
    }
    if (mouseX > 320 && mouseX < 344 && mouseY < 214 && mouseY > 190)
    {
      p1.numFlames++;
      if (p1.numFlames > 1)
        p1.numFlames = 0;
    }

    if (mouseX > 290 && mouseX < 314 && mouseY < 244 && mouseY > 220)
    {
      p1.flameC--;
      if (p1.flameC < 0)
        p1.flameC = colours.length -1;
    }
    if (mouseX > 320 && mouseX < 344 && mouseY < 244 && mouseY > 220)
    {
      p1.flameC++;
      if (p1.flameC > colours.length -1)
        p1.flameC = 0;
    }

    if (mouseX > 625 && mouseX < 649 && mouseY < 154 && mouseY > 130)
    {
      p1.packC--;
      if (p1.packC < 0)
        p1.packC = colours.length -1;
    }
    if (mouseX > 655 && mouseX < 679 && mouseY < 154 && mouseY > 130)
    {
      p1.packC++;
      if (p1.packC > colours.length -1)
        p1.packC = 0;
    }

    if (mouseX > 625 && mouseX < 649 && mouseY < 184 && mouseY > 160)
    {
      p1.baseC--;
      if (p1.baseC < 0)
        p1.baseC = colours.length -1;
    }
    if (mouseX > 655 && mouseX < 679 && mouseY < 184 && mouseY > 160)
    {
      p1.baseC++;
      if (p1.baseC > colours.length -1)
        p1.baseC = 0;
    }

    if (mouseX > 625 && mouseX < 649 && mouseY < 214 && mouseY > 190)
    {
      p1.strapC--;
      if (p1.strapC < 0)
        p1.strapC = colours.length -1;
    }
    if (mouseX > 655 && mouseX < 679 && mouseY < 214 && mouseY > 190)
    {
      p1.strapC++;
      if (p1.strapC > colours.length -1)
        p1.strapC = 0;
    }

    if (mouseX > 625 && mouseX < 649 && mouseY < 244 && mouseY > 220)
    {
      p1.buckleC--;
      if (p1.buckleC < 0)
        p1.buckleC = colours.length -1;
    }
    if (mouseX > 655 && mouseX < 679 && mouseY < 244 && mouseY > 220)
    {
      p1.buckleC++;
      if (p1.buckleC > colours.length -1)
        p1.buckleC = 0;
    }



    if (mouseX > 290 && mouseX < 314 && mouseY < 154 + height/2 && mouseY > 130 + height/2)
    {
      p2.tool--;
      if (p2.tool < 0)
        p2.tool = 2;
    }
    if (mouseX > 320 && mouseX < 344 && mouseY < 154 + height/2 && mouseY > 130 + height/2)
    {
      p2.tool++;
      if (p2.tool > 2)
        p2.tool = 0;
    }

    if (mouseX > 290 && mouseX < 314 && mouseY < 184 + height/2 && mouseY > 160 + height/2)
    {
      p2.toolC--;
      if (p2.toolC < 0)
        p2.toolC = p2.colours.length -1;
    }
    if (mouseX > 320 && mouseX < 344 && mouseY < 184 + height/2 && mouseY > 160 + height/2)
    {
      p2.toolC++;
      if (p2.toolC > p2.colours.length -1)
        p2.toolC = 0;
    }

    if (mouseX > 290 && mouseX < 314 && mouseY < 214 + height/2 && mouseY > 190 + height/2)
    {
      p2.numFlames--;
      if (p2.numFlames < 0)
        p2.numFlames = 1;
    }
    if (mouseX > 320 && mouseX < 344 && mouseY < 214 + height/2 && mouseY > 190 + height/2)
    {
      p2.numFlames++;
      if (p2.numFlames > 1)
        p2.numFlames = 0;
    }

    if (mouseX > 290 && mouseX < 314 && mouseY < 244 + height/2 && mouseY > 220 + height/2)
    {
      p2.flameC--;
      if (p2.flameC < 0)
        p2.flameC = p2.colours.length -1;
    }
    if (mouseX > 320 && mouseX < 344 && mouseY < 244 + height/2 && mouseY > 220 + height/2)
    {
      p2.flameC++;
      if (p2.flameC > p2.colours.length -1)
        p2.flameC = 0;
    }

    if (mouseX > 625 && mouseX < 649 && mouseY < 154 + height/2 && mouseY > 130 + height/2)
    {
      p2.packC--;
      if (p2.packC < 0)
        p2.packC = p2.colours.length -1;
    }
    if (mouseX > 655 && mouseX < 679 && mouseY < 154 + height/2 && mouseY > 130 + height/2)
    {
      p2.packC++;
      if (p2.packC > p2.colours.length -1)
        p2.packC = 0;
    }

    if (mouseX > 625 && mouseX < 649 && mouseY < 184 + height/2 && mouseY > 160 + height/2)
    {
      p2.baseC--;
      if (p2.baseC < 0)
        p2.baseC = p2.colours.length -1;
    }
    if (mouseX > 655 && mouseX < 679 && mouseY < 184 + height/2 && mouseY > 160 + height/2)
    {
      p2.baseC++;
      if (p2.baseC > p2.colours.length -1)
        p2.baseC = 0;
    }

    if (mouseX > 625 && mouseX < 649 && mouseY < 214 + height/2 && mouseY > 190 + height/2)
    {
      p2.strapC--;
      if (p2.strapC < 0)
        p2.strapC = p2.colours.length -1;
    }
    if (mouseX > 655 && mouseX < 679 && mouseY < 214 + height/2 && mouseY > 190 + height/2)
    {
      p2.strapC++;
      if (p2.strapC > p2.colours.length -1)
        p2.strapC = 0;
    }

    if (mouseX > 625 && mouseX < 649 && mouseY < 244 + height/2 && mouseY > 220 + height/2)
    {
      p2.buckleC--;
      if (p2.buckleC < 0)
        p2.buckleC = p2.colours.length -1;
    }
    if (mouseX > 655 && mouseX < 679 && mouseY < 244 + height/2 && mouseY > 220 + height/2)
    {
      p2.buckleC++;
      if (p2.buckleC > p2.colours.length -1)
        p2.buckleC = 0;
    }
  }

  /*
  int tool = 0; //sword or lance
   int toolC = 0;
   int numFlames = 1;
   int flameC = 0;
   int packC = 0;
   int baseC = 0;
   int strapC = 0;
   int buckleC = 0;
   translate(0, 16);
   rect(300,126, 24, 24);
   rect(300,156, 24, 24);
   rect(300,186, 24, 24);
   rect(300,216, 24, 24);
   rect(625,126, 24, 24);
   rect(625,156, 24, 24);
   rect(625,186, 24, 24);
   rect(625,216, 24, 24);
   popMatrix();
   
   pushMatrix();
   noFill();
   translate(30, 16);
   rect(300,126, 24, 24);
   rect(300,156, 24, 24);
   rect(300,186, 24, 24);
   rect(300,216, 24, 24);
   rect(625,126, 24, 24);
   rect(625,156, 24, 24);
   rect(625,186, 24, 24);
   rect(625,216, 24, 24);
   popMatrix();
   pushMatrix();
   translate(0, height/2);
   
   text("Weapon Type", 65, 150);
   text("Weapon Colour", 65, 180);
   text("Number of Flames", 65, 210);
   text("Flame Colour", 65, 240);
   text("Thruster Colour", 400, 150);
   text("Base Colour", 400, 180.0);
   text("Strap Colour", 400, 210);
   text("Buckle Colour", 400, 240);
   
   pushMatrix();
   noFill();
   translate(0, 16);
   rect(300,126, 24, 24);
   rect(300,156, 24, 24);
   rect(300,186, 24, 24);
   rect(300,216, 24, 24);
   rect(625,126, 24, 24);
   rect(625,156, 24, 24);
   rect(625,186, 24, 24);
   rect(625,216, 24, 24);
   popMatrix();
   
   pushMatrix();
   noFill();
   translate(30, 16);
   rect(300,126, 24, 24);
   rect(300,156, 24, 24);
   rect(300,186, 24, 24);
   rect(300,216, 24, 24);
   rect(625,126, 24, 24);
   rect(625,156, 24, 24);
   rect(625,186, 24, 24);
   rect(625,216, 24, 24);
   popMatrix();
   popMatrix();
   */
}

boolean sketchFullScreen() {
  return true;
}
/*rect(50, height/2 - 42.5, 25, 25);
 text("Three rounds.", 80, height/2 - 22.5);
 rect(50, height/2 - 12.5, 25, 25);
 text("Five rounds.", 80, height/2 + 7.5);
 rect(50, height/2 + 17.5, 25, 25);
 text("Seven rounds.", 80, height/2 + 37.5);*/
