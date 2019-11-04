int cellSize = 50; //if size is changed to (1000,1000), pls change this to 100.
int gameState = 0;
int turn = -1;
Chara blueTeam[] = new Chara[6];
Chara redTeam[] = new Chara[6];
Cell cells[] = new Cell[36];
int t = 0;
int count; //counts how many troops have been selected
boolean mouseReleased = true;
boolean first = true; //helps run a one time code for each gameState

//these are the characters that are actually in the fight, now with stats and behaviors
Chara blue1;
Chara blue2;
Chara blue3;
Chara red1;
Chara red2;
Chara red3;

//THESE VARIABLES TRACK THE POSITION OF THE CHARACTERS
//float blue1x;
//float blue1y;
//float blue2x;
//float blue2y;
//float blue3x;
//float blue3y;
//float red1x;
//float red1y;
//float red2x;
//float red2y;
//float red3x;
//float red3y;



void setup() {
  size(500, 500);
  rectMode(CENTER);
  smooth();

  //initialize characters
  for (int i = 0; i < blueTeam.length; i++) {
    blueTeam[i] = new Chara(color(0, 0, 200), i, true, 0);
  }

  for (int i = 0; i < redTeam.length; i++) {
    redTeam[i] = new Chara(color(200, 0, 0), i, false, 0);
  }

  //initialize cells


  for (float n = cellSize*2.5; n < height-cellSize*1.5; n += cellSize) {
    for (float i = cellSize*3; i < width-cellSize*1; i += cellSize) {
      cells[t] = new Cell(n, i);
      t++;
    }
  }
}

void draw() {

  //BLUE TEAM SELECT
  if (gameState == 0) { 
    if (first == true) {
      count = 0; 
      first = false;
      //println("oh");
    }



    background(255);

    drawBorders();

    //draw choosable characters
    int a = 0;
    for (int i = 2*width/5; i <= 3*width/5; i += width/5) {
      for (int n = height/5; n <= 3*height/5; n += height/5) {
        blueTeam[a].exist(i, n);
        a++;
      }
    }

    //draw chosen characters
    for (int b = 0; b < blueTeam.length; b++) {
      blueTeam[b].choose(); 
      blueTeam[b].chosen();
    }

    //debug line
    if (key == 'a') {
      first = true;
      gameState = 1;
    }
  }





  //RED TEAM SELECT
  if (gameState == 1) { 

    if (first == true) {
      count = 0; 
      first = false;
      //println("oh");
    }
    background(255);
    drawBorders();

    //draw choosable characters
    int a = 0;
    for (int i = 2*width/5; i <= 3*width/5; i += width/5) {
      for (int n = height/5; n <= 3*height/5; n += height/5) {
        redTeam[a].exist(i, n);
        a++;
      }
    }

    //draw chosen characters
    for (int b = 0; b < blueTeam.length; b++) {
      redTeam[b].choose(); 
      redTeam[b].chosen();
      blueTeam[b].chosen();
    }

    //debug line
    if (key == 's') {
      gameState = 2;
    }
  }

  //PREPARE BY COPYING THE CLASSES OUTSIDE OF THE ARRAY FOR EASIER ACCESS
  if (gameState == 2) { 
    for (int n = 0; n < blueTeam.length; n++) {
      if (blueTeam[n].chosen1 == true) {
        blue1 = blueTeam[n];
        blue1.id = 1;
        blue1.initializeStats();
      }
    }

    for (int n = 0; n < blueTeam.length; n++) {
      if (blueTeam[n].chosen2 == true) {
        blue2 = blueTeam[n];
        blue2.id = 2;
        blue2.initializeStats();
      }
    }

    for (int n = 0; n < blueTeam.length; n++) {
      if (blueTeam[n].chosen3 == true) {
        blue3 = blueTeam[n];
        blue3.id = 3;
        blue3.initializeStats();
      }
    }

    for (int n = 0; n < redTeam.length; n++) {
      if (redTeam[n].chosen1 == true) {
        red1 = redTeam[n];
        red1.id = 4;
        red1.initializeStats();
      }
    }

    for (int n = 0; n < redTeam.length; n++) {
      if (redTeam[n].chosen2 == true) {
        red2 = redTeam[n];
        red2.id = 5;
        red2.initializeStats();
      }
    }

    for (int n = 0; n < redTeam.length; n++) {
      if (redTeam[n].chosen3 == true) {
        red3 = redTeam[n];
        red3.id = 6;
        red3.initializeStats();
      }
    }

    //gives the starting positions of each character
    blue1.X = cells[3].locationX;
    blue1.Y = cells[3].locationY;
    println(cells[0].locationX);
    println(blue1.location);
    blue2.X = cells[8].locationX;
    blue2.Y = cells[8].locationY;
    println(blue2.location);

    blue3.X = cells[20].locationX;
    blue3.Y = cells[20].locationY;
    println(blue3.location);

    red1.X = cells[24].locationX;
    red1.Y = cells[24].locationY;
    red2.X = cells[30].locationX;
    red2.Y = cells[30].locationY;
    red3.X = cells[31].locationX;
    red3.Y = cells[31].locationY;
    first = true;
    gameState = 3;
    println(blue1.location);
  }




  //THIS IS WHERE THE BATTLE HAPPENS
  if (gameState == 3) { 
    if (first) {
      println(blue1.location);
      //first = false;
    }
    background(255);
    for (int n = 0; n < cells.length; n++) {
      cells[n].drawCell();
      cells[n].chooseCell();
    }
    if (first) {
      println(blue1.location);
    }
    blue1.exist(int(blue1.X), int(blue1.Y));
    if (first) {
      println(blue1.location);
      //first = false;
    }
    blue2.exist(int(blue2.X), int(blue2.Y));
    blue3.exist(int(blue3.X), int(blue3.Y));
    red1.exist(int(red1.X), int(red1.Y));
    red2.exist(int(red2.X), int(red2.Y));
    red3.exist(int(red3.X), int(red3.Y));

//THIS DISPLAYS WHOSE TURN IT IS
    if (turn == -1) { //blue player turn
      textSize(36);
      fill(0, 0, 255);
      text("BLUE PLAYER TURN", width/2, 75, width, 80);

      if (key == 'p') { //NEXT TURN
        turn *= -1;
      }
    }
    if (turn == 1) { //red player turn
      textSize(36);
      fill(255, 0, 0);
      text("RED PLAYER TURN", width/2, 75, width, 80);

      if (key == 'q') { //NEXT TURN
        turn *= -1;
      }
    }
    if (first) {
      println(blue1.location);
      println(blue2.location, blue2.X, blue2.Y);
      println(cells[blue1.location].locationX, cells[blue1.location].locationY);
      first = false;
    }
  }

  if (gameState == 4) { //results screen
  }
}





void drawBorders() {
  strokeWeight(3);
  stroke(0);
  line(width/5, 0, width/5, height);
  line(4*width/5, 0, 4*width/5, height);
}

class Cell { //this should allow to have several clickable cells

  float locationX, locationY;
  color c = 255;
  boolean selected = false;

  Cell(float lx, float ly) {
    locationX = lx;
    locationY = ly;
  }

  void drawCell() {

    //detects if mouse is over cell
    if (mouseX < locationX-cellSize/2 || mouseX > locationX+cellSize/2 || mouseY < locationY-cellSize/2 || mouseY > locationY+cellSize/2) {
      fill(c);
    }
    if (mouseX < locationX+cellSize/2 && mouseX > locationX-cellSize/2 && mouseY < locationY+cellSize/2 && mouseY > locationY-cellSize/2) {
      fill(150);
      selected = true;
      //println(locationY);
    }
    stroke(0);
    rect(locationX, locationY, cellSize, cellSize);
  }

  void chooseCell() {
    if(selected == true && mousePressed == true){
      locationX = selectCell().x;
      locationY = selectCell().y;
    }
  }
  PVector selectCell() {    
    PVector center = new PVector(locationX, locationY);
    return center;
  }
}

class Chara { //this contains all different character types
  color c;
  float size = cellSize*0.7;
  int job; //this variable decides which character type gets drawn
  boolean team; //true is blue, false is red
  int id; //to tell which character specifically it is
  boolean selected = true;
  boolean chosen1 = false;
  boolean chosen2 = false;
  boolean chosen3 = false;
  float X;
  float Y;

  int HP;
  int Movement;
  int Attack;

  int location;

  Chara(color C, int Job, boolean Team, int ID) {
    c = C;
    job = Job;
    team = Team;
    id = ID;
  }

  //draws chara at locationd accounting for job - also does everything else
  void exist(int a, int b) { 
    X = float(a);
    Y = float(b);
    if (first) {
      println(blue1.location);
      //first = false;
    }
    //PROTECTOR
    if (job == 0) {
      drawTank(a, b);
      if (gameState >= 2) {
        if (mousePressed && selected) {
          detectLocation();
          activateMenu();
        }
      }
    }

    //ATTACKER
    if (job == 1) {
      drawAttacker(a, b);
      if (gameState >= 2) {
        if (mousePressed && selected) {
          activateMenu();
        }
      }
    }

    //RANGER
    if (job == 2) {
      drawRanger(a, b);
    }

    //MAGE
    if (job == 3) {
      drawMage(a, b);
    }

    //HEALER
    if (job == 4) {
      drawHealer(a, b);
    }

    //BARD
    if (job == 5) {
      drawBard(a, b);
    }
  }


  //SHOWS SELECTED CHARACTERS ON BORDER
  void chosen() {
    //FOR BLUE TEAM
    if (team == true && (gameState == 0 || gameState == 1)) {
      if (chosen1) {
        exist(width/7, height/5);
      }
      if (chosen2) {
        exist(width/7, 2*height/5);
      }
      if (chosen3) {
        exist(width/7, 3*height/5);
      }
    }
    //FOR RED TEAM
    if (team == false && gameState == 1) {
      if (chosen1) {
        exist(6*width/7, height/5);
      }
      if (chosen2) {
        exist(6*width/7, 2*height/5);
      }
      if (chosen3) {
        exist(6*width/7, 3*height/5);
      }
    }
  }



  void drawTank(int x, int y) {
    pushMatrix();
    translate(x, y);
    fill(c);
    checkBounds(x, y);
    noStroke();
    rect(0, 0, size, size);
    fill(255);
    rect(0, 0, size/5, 6*size/10);
    popMatrix();
  }

  void drawAttacker(int x, int y) {
    pushMatrix();
    translate(x, y);
    fill(c);
    checkBounds(x, y);
    noStroke();
    quad(-size/3, 0, 0, -size/2, size/3, 0, 0, size/2);
    popMatrix();
  }

  void drawRanger(int x, int y) {
    pushMatrix();
    translate(x, y);
    checkBounds(x, y);
    noStroke();
    fill(c);
    rect(0, 0, 4*size/5, 4*size/5);
    fill(200);
    triangle(0, 0, -2*size/5, -2*size/5, 2*size/5, -2*size/5);
    popMatrix();
  }

  void drawMage(int x, int y) {
    pushMatrix();
    translate(x, y);
    fill(c);
    checkBounds(x, y);
    noStroke();
    fill(200);
    scale(0.82);
    quad(0, 0, -size/5, -size/4, 0, -7*size/10, size/5, -size/4);
    fill(c);
    for (int i = 4; i > 0; i--) {
      rotate(radians(72));
      quad(0, 0, -size/5, -size/4, 0, -7*size/10, size/5, -size/4);
    }
    popMatrix();
  }

  void drawHealer(int x, int y) {
    pushMatrix();
    translate(x, y);
    fill(c);
    checkBounds(x, y);
    noStroke();
    noStroke();
    quad(-15*size/100, 0, 15*size/100, 0, 15*size/100, -size/2, -15*size/100, -size/2);
    for (int i = 3; i > 0; i--) {
      rotate(HALF_PI);
      quad(-15*size/100, 0, 15*size/100, 0, 15*size/100, -size/2, -15*size/100, -size/2);
    }
    popMatrix();
  }

  void drawBard(int x, int y) {
    pushMatrix();
    translate(x, y);
    fill(c);
    checkBounds(x, y);
    noStroke();
    triangle(0, size/2, -size/5, -size/2, -size/2, size/2);
    triangle(0, size/2, size/4, -size/2, size/2, size/2);
    popMatrix();
  }


  //checks if mouse is over character. does corresponding action
  void checkBounds(int x, int y) { //checks if mouse is over character or not
    if (mouseX < float(x)-size/2 || mouseX > float(x)+size/2 || mouseY < float(y)-size/2 || mouseY > float(y)+size/2) {
      selected = false;
      //print(job);
    }
    if (mouseX < float(x)+size/2 && mouseX > float(x)-size/2 && mouseY < float(y)+size/2 && mouseY > float(y)-size/2) {
      scale(1.2);
      selected = true;
      if (job == 0) {
        textSize(10);
        text("Protector", 0, size, 1.3*size, size);
      }
      if (job == 1) {
        textSize(11);
        text("Attacker", 0, size, 1.3*size, size);
        //println("hi");
      }
      if (job == 2) {
        textSize(11);
        text("Ranger", 0, size, 1.1*size, size);
      }
      if (job == 3) {
        textSize(11);
        text("Mage", 0, size, 0.85*size, size);
      }
      if (job == 4) {
        textSize(11);
        text("Healer", 0, size, 1.1*size, size);
      }
      if (job == 5) {
        textSize(11);
        text("Bard", 0, size, 0.8*size, size);
      }
    }
  }


  //selects character from the gamestate 0 or 1 screens. 
  void choose() {
    // println(mouseY);
    if (gameState == 0 || gameState == 1) {
      if (mousePressed == true && selected == true && mouseReleased == true) {
        mouseReleased = false;
        if (count == 2) {
          chosen3 = true;
          count++;
        }
        if (count == 1) {
          chosen2 = true;
          count++;
        }
        if (count == 0) {
          chosen1 = true;
          count++;
        }
      }
    }
    if (mousePressed == false) {
      mouseReleased = true;
    }
  }

  //INITIALIZE STATS AT THE START OF THE BATTLE
  void initializeStats() { 

    //PROTECTOR
    if (job == 0) {
      HP = 20;
      Movement = 2;
      Attack = 3;
    }

    //ATTACKER
    if (job == 1) {
      HP = 20;
      Movement = 2;
      Attack = 3;
    }

    //RANGER
    if (job == 2) {
      HP = 20;
      Movement = 2;
      Attack = 3;
    }

    //MAGE
    if (job == 3) {
      HP = 20;
      Movement = 2;
      Attack = 3;
    }

    //HEALER
    if (job == 4) {
      HP = 20;
      Movement = 2;
      Attack = 3;
    }

    //BARD
    if (job == 5) {
      HP = 20;
      Movement = 2;
      Attack = 3;
    }
  }

  void takeDamage(int dmg) {
    HP -= dmg;
  }

  void detectLocation() {
    if (gameState >= 2) {
      for (int n = 0; n<cells.length; n++) {
        if (id == 1 && X == cells[n].locationX && Y == cells[n].locationY) {
          location = n;
          println(blue1.location);
        }
      }
      for (int n = 0; n<cells.length; n++) {
        if (id == 2 && X == cells[n].locationX && Y == cells[n].locationY) {
          location = n;
        }
      }
      for (int n = 0; n<cells.length; n++) {
        if (id == 3 && X == cells[n].locationX && Y == cells[n].locationY) {
          location = n;
        }
      }
      for (int n = 0; n<cells.length; n++) {
        if (id == 4 && X == cells[n].locationX && Y == cells[n].locationY) {
          location = n;
        }
      }
      for (int n = 0; n<cells.length; n++) {
        if (id == 5 && X == cells[n].locationX && Y == cells[n].locationY) {
          location = n;
        }
      }
      for (int n = 0; n<cells.length; n++) {
        if (id == 6 && X == cells[n].locationX && Y == cells[n].locationY) {
          location = n;
        }
      }
    }
  }

  void activateMenu() {
    //PROTECTOR
    textSize(10);
    fill(0);
    text("Press m to move", width-100, 30, 200, 50);
    text("Press k to attack", width-100, 50, 200, 50);

    if (job == 0) {
      if (keyPressed) {
        if (key == 'm') {
          cells[location].c = c;
          if ((location+1)%6 != 0) { //these if statements keep it from coloring a cell that doesn't exist or is incorrect
            cells[location+1].c = c;
          }
          if ((location+1)%6 != 5 && (location+1)%6 != 0) {
            cells[location+2].c = c;
          }
          if ((location+1)%6 != 1) {
            cells[location-1].c = c;
          }
          if ((location+1)%6 != 2) {
            cells[location-2].c = c;
          }
          if (location+6 <= 35) {
            cells[location+6].c = c;
          }
          if (location+12 <= 35) {
            cells[location+12].c = c;
          }    
          if (location-6 >= 0) {
            cells[location-6].c = c;
          }
          if (location-12 >= 0) {
            cells[location-12].c = c;
          }
          if (location-6 >= 0 && (location+1)%6 != 1) {
            cells[location-7].c = c;
          }
          if (location-6 >= 0 && (location+1)%6 != 0) {
            cells[location-5].c = c;
          }
          if (location+6 <= 35 && (location+1)%6 != 1) {
            cells[location+5].c = c;
          }
          if (location+6 <= 35 && (location+1)%6 != 0) {
            cells[location+7].c = c;
          }
        }
        if (key == 'k') {
        }
      }
    }
  }
}
