//player movement
boolean Up = false;
boolean Down = false;
boolean Left = false;
boolean Right = false;

Player p1 = new Player(); 

//Keeps track of which game is being played
int GameState = 0; 

//Keeps track of which game has been cleared
boolean d_ball_clear = false; 
boolean c_ball_clear = false; 
boolean b_ball_clear = false; 

EnemyG1[] enemy1 = new EnemyG1[10]; //enemies for G1

//portals
G1 d_ball = new G1(); 
G2 c_ball = new G2();
G3 b_ball = new G3();

//death barriers for G1
Border top; 
Border right;
Border bottom;
Border left;


Score_G1 Game_1 = new Score_G1(); //Score for G1


int G2_TimerE = 0; //Start timers for G2 counting for the enemies
int G2_SpawnE = 30; //Sets how fast enemies spawn
int G2_TimerPU = 0; //Starts a timer for the pick-ups
int G2_SpawnPU = 100; //Sets how fast pick-ups appear
Drop_Off dropoff = new Drop_Off(); //drop off for G2
Score_G2 Game_2 = new Score_G2(); //Score for G2
EnemyG2[] enemy2 = new EnemyG2[0]; //enemies for G2
Pick_Up_G2[] pickup2 = new Pick_Up_G2[0]; //Pick ups for G2


EnemyG1[] enemy3 = new EnemyG1[7]; //enemies for G3
Pick_Up_G3 pickup3 = new Pick_Up_G3(); //pickups for G3
Score_G3 Game_3 = new Score_G3();

//High Scores for each game
int HiScore_1 = 0;
int HiScore_2 = 0;
int HiScore_3 = 0;


void setup() {
  size(1000, 800);

  //initialize the borders for game 1
  top = new Border(new PVector(5, 5), new PVector(width - 5, 5), 5, color(255, 0, 0));
  right = new Border(new PVector(width - 5, 5), new PVector(width - 5, height - 5), 5, color(255, 0, 0));
  bottom = new Border(new PVector(width - 5, height - 5), new PVector(5, height - 5), 5, color(255, 0, 0));
  left = new Border(new PVector(5, height - 5), new PVector(5, 5), 5, color(255, 0, 0));
}

void draw() {

  if (GameState == 0) {
    background(0);

    reset();
    d_ball.exist();
    d_ball.warp();
    c_ball.warp();
    c_ball.exist();
    b_ball.exist();
    b_ball.warp();
    p1.exist();
    
    //print out a message if all games are clear
    if (d_ball_clear == true && c_ball_clear == true && b_ball_clear == true) {
      fill(255);
      textSize(50);
      text("CONGRATULATIONS!", 300, 200);
      //println("ok");
    }
  }
  if (GameState == 1) {
    background(0);
    p1.X = width/2;
    p1.Y = height/2;
    //println(GameState);
    textSize(40);
    fill(255);
    text("HOMEWORK #2", 250, 100);
    text("Avoid the red balls!", 200, 300);
    text("Survive as long as you can!", 150, 400);
    text("Target score: 2500", 200, 500);
    text("Press SHIFT to start!", 250, 600);
    if (keyCode == SHIFT) {
      GameState = 2;
    }
  }
  if (GameState == 2) {
    background(0);

    p1.exist();
    for (EnemyG1 e : enemy1) {
      e.exist();
    }
    top.exist();
    left.exist();
    right.exist();
    bottom.exist();
    Game_1.display();
  }
  if (GameState == 3) {
    //println(GameState);
    background(0);
    p1.X = width/2;
    p1.Y = height/2;
    textSize(40);
    fill(255);
    text("HOMEWORK #4", 250, 100);
    text("Avoid the red squares!", 200, 300);
    text("Collect blue squares and drop at green!", 100, 400);
    text("Target score: 15000", 200, 500);
    text("Press SHIFT to start!", 250, 600);
    if (keyCode == SHIFT) {
      GameState = 4;
    }
  }
  if (GameState == 4) {
    //println(GameState);
    background(0);
    dropoff.exist();
    p1.exist();
    G2_TimerE ++;
    G2_TimerPU ++;
    for (int n = 0; n<enemy2.length; n++) {
      enemy2[n].exist();
    }
    for (int n = 0; n<pickup2.length; n++) {
      if (pickup2[n].alive == false) {
        continue;
      }
      pickup2[n].exist();
    }
    if (G2_TimerE == G2_SpawnE) {
      EnemyG2 e = new EnemyG2();
      enemy2 = (EnemyG2[])append(enemy2, e);
      G2_TimerE = 0;
    }
    if (G2_TimerPU == G2_SpawnPU) {
      Pick_Up_G2 pu = new Pick_Up_G2();
      pickup2 = (Pick_Up_G2[])append(pickup2, pu);
      G2_TimerPU = 0;
    }
    Game_2.display();
  }
  if (GameState == 5) {
    background(0);
    p1.X = width/2;
    p1.Y = height/2;
    textSize(40);
    fill(255);
    text("HOMEWORK #5", 250, 100);
    text("Avoid the red circles!", 200, 300);
    text("Collect blue squares!", 200, 400);
    text("Target score: 120", 200, 500);
    text("Press SHIFT to start!", 250, 600);
    if (keyCode == SHIFT) {
      GameState = 6;
    }
  }
  if (GameState == 6) {
    background(0);
    p1.exist();
    for (EnemyG1 e : enemy3) {
      e.exist();
    }
    pickup3.exist();
    Game_3.display();
  }
}

//Makes borders that kill the player when they touch it

class Border {
  PVector pos1;
  PVector pos2;
  color C;
  int Stroke;

  Border(PVector p1, PVector p2, int s, color c) {
    pos1 = p1;
    pos2 = p2;
    Stroke = s;
    C = c;
  }
  
  //this function draws them and 
  void exist() {
    stroke(C);
    strokeWeight(Stroke);
    line(pos1.x, pos1.y, pos2.x, pos2.y);  
    if (p1.Y == pos1.y && p1.X != pos1.x) {
      GameState = 0;
    }
    if (p1.X == pos1.x && p1.Y != pos1.y) {
      GameState = 0;
    }
  }
}

//Makes a square where the player has to go to to get points, and also make themselves smaller
class Drop_Off {
  color C = color(0, 255, 0);
  float Size = 100;
  PVector pos = new PVector(800, 400);

  //this draws it and activates it
  void exist() {
    fill(C);
    rect(pos.x, pos.y, Size, Size); 
    if (dist(pos.x+Size/2, pos.y+Size/2, p1.X, p1.Y) < Size/2+p1.Size-10 && p1.Size > 20) {
      p1.Size --;
      Game_2.T += p1.Size;
    }
  }
}

class Enemy {
  color C;
  boolean alive;

  Enemy() {
    C = color(255, 0, 0);
    alive = true;
  }
}


//Enemies in Game 1 - they move around the screen and bounce off the walls
class EnemyG1 extends Enemy {
  PVector Pos = new PVector(random(20, width - 20), random(20, height - 20));
  {
    while (dist(Pos.x, Pos.y, p1.X, p1.Y) < 20) {
      Pos = new PVector(random(20, width - 20), random(20, height - 20));
    }
  }
  float Size = 60;
  PVector Vel = new PVector(random(-6, 6), random(-6, 6));
  {
    while (Vel.x == 0 || Vel.y == 0) {
      Vel = new PVector(random(-6, 6), random(-6, 6));
    }
  }
  void exist () {
    noStroke();
    fill(C);
    ellipse(Pos.x, Pos.y, Size, Size);
    Pos.x += Vel.x;
    Pos.y += Vel.y;
    if (Pos.x-Size < 2 || Pos.x+Size > width - 2) {
      Vel.x *= -1.0001;
    }
    if (Pos.y-Size < 2 || Pos.y+Size > height - 2) {
      Vel.y *= -1.0001;
    }
    if (dist(Pos.x, Pos.y, p1.X, p1.Y) < Size || dist(Pos.x, Pos.y, p1.X, p1.Y) < p1.Size/2) {
      GameState = 0;
    }
  }
}

//Enemies from Game 2 - they are squares that flow from one side of the screen to the other
class EnemyG2 extends Enemy {
  PVector Pos = new PVector(0, random(0, height));
  float Size = random(10, 100);
  int Vel = int(random(1, 5));
  {

    //keeps it from having a velocity of 3
    while (Vel == 3) {
      Vel = int(random(1, 5));
    }
  }

  void exist() {
    stroke(0);
    strokeWeight(4);
    fill(C);
    rect(Pos.x, Pos.y, Size, Size);
    Pos.x += Vel;

    //if they touch the player, go back to the starting screen
    if (dist(Pos.x+Size/2, Pos.y+Size/2, p1.X, p1.Y) < p1.Size/2) {
      GameState = 0;
    }
  }
}

//Makes the portals to go into the games - they have sub-classes for each game
class Hut { 
  float Size;

  Hut() {
    Size = 100;
  }

  Hut(float size) {
    Size = size;
  }
}

class G1 extends Hut {
  float X = 100;
  float Y = 600;
  color C;
  void warp() {
    if (dist(p1.X, p1.Y, X + Size, Y + Size) < 50) {
      GameState = 1;
    }
  }
  void exist() {
    C = color(100);
    fill(C);
    noStroke();
    if (d_ball_clear == true) {
      fill(0, 255, 0);
    }
    rect(X, Y, Size, Size);
    fill(255);
    textSize(12);
    text("Game 1", X, Y+(Size+20));
    text("High Score: " + HiScore_1, X, Y+(Size + 70));
  }
}

class G2 extends Hut {
  float X = 400;
  float Y = 600;
  color C = color(100);
  void warp() {
    if (dist(p1.X, p1.Y, X + Size, Y + Size) < 50) {
      GameState = 3;
    }
  }
  void exist() {
    noStroke();
    fill(C);
    if (c_ball_clear == true) {
      fill(0, 255, 0);
    }
    rect(X, Y, Size, Size);
    fill(255);
    textSize(12);
    text("Game 2", X, Y+(Size+20));
    text("High Score: " + HiScore_2, X, Y+(Size + 70));
  }
}

class G3 extends Hut {
  float X = 700;
  float Y = 600;
  color C = color(100);
  void warp() {
    if (dist(p1.X, p1.Y, X + Size, Y + Size) < 50) {
      GameState = 5;
    }
  }
  void exist() {
    noStroke();
    fill(C);
    if (b_ball_clear == true) {
      fill(0, 255, 0);
    }
    rect(X, Y, Size, Size);
    fill(255);
    textSize(12);
    text("Game 3", X, Y+(Size+20));
    text("High Score: " + HiScore_3, X, Y+(Size + 70));
  }
}

class Pick_Up {
  color C;
  //int Size;
  boolean alive;

  Pick_Up() {
    C = color(0, 0, 255);
    //Size = 10;
    alive = true;
  }
}

class Pick_Up_G2 extends Pick_Up {
  PVector pos = new PVector(0, random(10, height-10));
  float vel = 3;
  int Size = int(random (5, 20));

  void exist() {
    strokeWeight(4);
    fill(C);
    rect(pos.x, pos.y, Size, Size);
    pos.x += vel;
    if (dist(pos.x+Size/2, pos.y+Size/2, p1.X, p1.Y) < Size/2+p1.Size/2) {
      p1.Size += Size;
      alive = false;
    }
  }
}

class Pick_Up_G3 extends Pick_Up {
  int Size = 20;
  PVector pos = new PVector(random(20, 980-Size), random(20, 780-Size));
  {
    while (pos.x == p1.X && pos.y == p1.Y) {
      pos = new PVector(random(20, 980-Size), random(20, 780-Size));
    }
  }

  void exist() {
    fill(C);
    rect(pos.x, pos.y, Size, Size);
    if (dist(pos.x+Size/2, pos.y+Size/2, p1.X, p1.Y) < Size/2+p1.Size/2) {
      p1.Size += 10;
      Game_3.T += 10;
      pos = new PVector(random(20, 980-Size), random(20, 780-Size));
      {
        while (pos.x == p1.X && pos.y == p1.Y) {
          pos = new PVector(random(20, 980-Size), random(20, 780-Size));
        }
      }
    }
  }
}

class Player {
  float X;
  float Y;
  int Size;
  color C;
  PVector Vel;

  Player() {
    X = 500;
    Y = 500;
    Size = 20;
    C = (255);
    Vel = new PVector (5, 5);
  }

  Player(float x, float y, int size, color c, PVector vel) {
    X = x;
    Y = y;
    Size = size;
    C = c;
    Vel = vel;
  }
  void exist() {
    boolean Up = false;
    boolean Down = false;
    boolean Left = false;
    boolean Right = false;
    fill(C);
    noStroke();
    ellipse(X, Y, Size, Size); 
    if (X > width-Size/2) {
      X = width-Size/2;
    }
    if (X < 0+Size/2) {
      X = Size/2;
    }
    if (Y > height-Size/2) {
      Y = height - Size/2;
    }
    if (Y < 0+Size/2) {
      Y = Size/2;
    }
    if (keyPressed) {
      if (keyCode == UP || key == 'w' || key == 'W')
        Up = true;
      if (keyCode == DOWN || key == 's' || key == 'S')
        Down = true;
      if (keyCode == LEFT || key == 'a' || key == 'A')
        Left = true;
      if (keyCode == RIGHT || key == 'd' || key == 'D')
        Right = true;
    } else {
      if (keyCode == UP)
        Up = false;
      if (keyCode == DOWN)
        Down = false;
      if (keyCode == LEFT)
        Left = false;
      if (keyCode == RIGHT)
        Right = false;
    }
    if (Up == true) {
      Y -= Vel.y;
    }
    if (Down == true) {
      Y += Vel.y;
    }
    if (Right == true) {
      X += Vel.x;
    }
    if (Left == true) {
      X -= Vel.x;
    }
  }
}

//resets the position of enemies

void reset() {
  for (int n = 0; n < enemy1.length; n++) {
    enemy1[n] = new EnemyG1();
  }
  enemy2 = new EnemyG2[0];
  pickup2 = new Pick_Up_G2[0];
  background(0);

  //resets the score for the other games
  Game_1.reset();
  Game_2.reset();
  Game_3.reset();
  p1.Size = 20;
  for (int n = 0; n < enemy3.length; n++) {
    enemy3[n] = new EnemyG1();
  }
}

//This stores the score for the game
class Score {
  int Stroke;
  PVector pos;

  Score() {
    Stroke = 3;
    pos = new PVector(700, 100);
  }
}

class Score_G1 extends Score {
  int T = 0;
  color C = color(255);

  //resets the score
  void reset() {
    T = 0;
    C = color(255);
  }

  void display() {
    if (T > HiScore_1) {
      HiScore_1 = T;
    }
    T ++;
    fill (C);
    strokeWeight (Stroke);
    text("Score: " + T, pos.x, pos.y); 
    if (T > 2500) {
      C = color(0, 255, 0);
      d_ball_clear = true;
    }
  }
}

class Score_G2 extends Score {
  int T = 0;
  color C = color(255);

  void reset() {
    T = 0;
    C = color(255);
  }

  void display() {
    if (T > HiScore_2) {
      HiScore_2 = T;
    }
    fill (C);   
    strokeWeight (Stroke);
    text("Score: " + T, pos.x, pos.y); 
    if (T > 15000) {
      C = color(0, 255, 0);
      c_ball_clear = true;
    }
  }
}

class Score_G3 extends Score {
  int T = 0;
  color C = color(255);

  void reset() {
    T = 0;
    C = color(255);
  }
  void display() {
    if (T >= HiScore_3) {
      HiScore_3 = T;
    }
    fill (C);
    strokeWeight (Stroke);
    text("Score: " + T, pos.x, pos.y); 
    if (T > 120) {
      C = color(0, 255, 0);
      b_ball_clear = true;
    }
  }
}
