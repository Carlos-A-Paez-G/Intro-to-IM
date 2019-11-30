int TITLE = 0;
int TESTING = 100;
int gameState = TESTING;
int CHARA_SELECT = 1;

int blue = 0;
int red = 1;

Defender Defender_B = new Defender(blue, 1);
FightBall FightBall_B = new FightBall(blue, 2);
FlowerLady FlowerLady_B = new FlowerLady(blue, 3);
Swampy Swampy_R = new Swampy(red, 4);
Onion Onion_R = new Onion(red, 5);
StickRobo StickRobo_R = new StickRobo(red, 6);

//Fonts
PFont title;
PFont names;
PFont descriptions;
PFont plain;
PFont specialExtra;

int[][] cells = new int[][]{
  new int[] {1, 2, 3, 4}, 
  new int[] {1, 2, 3, 4}, 
};

String characters[] = {"DefenderN_B", "DefenderN_R", "Defender_B", "Defender_R", "Swampy_R", "Swampy_B", "StickRobo_B", "StickRobo_R", "FightBall_R", "FightBall_B", "FlowerLady_R", "FlowerLady_B", "Onion_B", "Onion_R"};
PImage charaPictures[] = new PImage[14];
PImage bckgrnd;

int Title_t = 0; //timer for title
int Title_p = 1; //for title blinking message
int choice;

int SELECT_tB = 0; //counts blue team button presses in chara select
int B_ChoiceCount = 0;
int B_Choice[] = {0, 0, 0};
color cB[] = new color[3];
boolean SELECT_redB = false;
boolean SELECT_blueB = false;
boolean SELECT_greenB = false;

int SELECT_tR = 0; //counts red team button presses in chara select
int R_ChoiceCount = 0;
int R_Choice[] = {0, 0, 0};
color cR[] = new color[3];
boolean SELECT_redR = false;
boolean SELECT_blueR = false;
boolean SELECT_greenR = false;

int SELECT_tText = 0;
int SELECT_showText = 1;

void setup() {
  size(800, 800);
  imageMode(CENTER);
  rectMode(CORNER);
  noStroke();
  bckgrnd = loadImage("background.jpg");
  charaPictures[0] = loadImage("DefenderN_B.png");
  charaPictures[1] = loadImage("DefenderN_R.png");
  charaPictures[2] = loadImage("Defender_B.png");
  charaPictures[3] = loadImage("Defender_R.png");
  charaPictures[4] = loadImage("Swampy_B.png");
  charaPictures[5] = loadImage("Swampy_R.png");
  charaPictures[6] = loadImage("StickRobo_B.png");
  charaPictures[7] = loadImage("StickRobo_R.png");
  charaPictures[8] = loadImage("FightBall_B.png");
  charaPictures[9] = loadImage("FightBall_R.png");
  charaPictures[10] = loadImage("FlowerLady_B.png");
  charaPictures[11] = loadImage("FlowerLady_R.png");
  charaPictures[12] = loadImage("Onion_B.png");
  charaPictures[13] = loadImage("Onion_R.png");

  //set fonts
  textAlign(CENTER);
  title = createFont("Sitka Banner Bold Italic", 64);
  plain = createFont("Sitka Banner", 28);
  names = createFont("Sitka Banner Bold", 44);
  descriptions = createFont("Sitka Banner Italic", 28);
  specialExtra = createFont("Sitka Banner Bold", 28);


  //debug - finding fonts
  String[] fontList = PFont.list();
  printArray(fontList);
}

void draw() {
  //draw background
  image(bckgrnd, width/2, height/2);

  if (gameState == TITLE) {
    //draws title of the game
    textFont(title);
    text("Micro Wars", width/2, 130);
    //draws blinking message
    if (Title_p == 1) {
      textFont(plain);
      text("-Push Button to Start-", width/2, height-130);
    }

    //chooses random chara to draw every 1.6 seconds

    if (Title_t == 0) {
      choice = int(random(2, charaPictures.length));
    }

    //draws corresponding character
    pushMatrix();
    translate(400, 400);
    //scales according to which character is chosen
    if (choice == 2 || choice == 3 || choice == 4 || choice == 5 || choice == 8 || choice == 9 ) {
      scale(0.5);
    }

    if (choice == 6 || choice == 7 || choice == 10 || choice == 11 || choice == 12 || choice == 13) {
      scale(0.4);
    }
    image(charaPictures[choice], 0, 0);
    popMatrix();

    //timed switch increase and reset
    Title_t++;
    if (Title_t == 100) {
      Title_t = 0;
      Title_p *= -1;
    }
    if (key == 'y') {
      gameState++;
    }
  }

  //********CHARACTER SELECT PHASE***********
  if (gameState == CHARA_SELECT) {
    //Blue Team loop
    textFont(title);
    fill(0, 0, 255);
    text("BLUE TEAM", 200, 100);
    if (B_ChoiceCount < 3) {
      SELECT_B();
    }
    B_Choice();

    //Red Team loop
    fill(255, 0, 0);
    text("RED TEAM", width-200, 100);
    if (R_ChoiceCount < 3) {
      SELECT_R();
    }
    R_Choice();

    if (R_ChoiceCount == 3 && B_ChoiceCount == 3) {
      if (SELECT_showText == 1) {
        textFont(names);
        fill(0);
        text("PUSH BUTTON TO START", width/2, height/2);
      }
      SELECT_tText++;
      if (SELECT_tText == 100) {
        SELECT_showText *= -1;
        SELECT_tText = 0;
      }
    }
  }
  
  //*********USE TO TEST THINGS************
  if (gameState == TESTING) {
    Onion_R.MenuDisplay();
    Defender_B.hpDisplay();
    FightBall_B.hpDisplay();
    FlowerLady_B.hpDisplay();
    Swampy_R.hpDisplay();
    Onion_R.hpDisplay();
    StickRobo_R.hpDisplay();
  }
}

void keyReleased() {
  //resets the selection when button is released, so that next choice isn't automatically made by holding button
  if (gameState == CHARA_SELECT) {
    if (SELECT_tB == 3) {
      SELECT_Breset();
    }
    if (SELECT_tR == 3) {
      SELECT_Rreset();
    }
  }
}

//CHARACTER_SELECT functions

//**BLUE TEAM**
void SELECT_B() {

  if (keyPressed) {
    if (SELECT_tB < 3) {
      if (key == 'a') {
        cB[SELECT_tB] = color(255, 0, 0);
        if (!SELECT_redB) {
          SELECT_tB++;
        }
        SELECT_redB = true;
      }
      if (key == 's') {
        cB[SELECT_tB] = color(0, 255, 0);
        if (!SELECT_greenB) {
          SELECT_tB++;
        }
        SELECT_greenB = true;
      }
      if (key == 'd') {
        cB[SELECT_tB] = color(0, 0, 255);
        if (!SELECT_blueB) {
          SELECT_tB++;
        }
        SELECT_blueB = true;
      }
    }
  }
  drawChosenB();
}

void drawChosenB() {
  noStroke();
  if (SELECT_tB > 0) {
    fill(cB[0]);
    ellipse(30, height-40, 20, 20);
  }
  if (SELECT_tB > 1) {
    fill(cB[1]);
    ellipse(60, height-40, 20, 20);
  }
  if (SELECT_tB > 2) {
    fill(cB[2]);
    ellipse(90, height-40, 20, 20);
  }
}

//resets process
void SELECT_Breset() {
  SELECT_tB = 0;
  for (int i = 0; i < cB.length; i++) {
    cB[i] = 0;
  }
  SELECT_blueB = false;
  SELECT_redB = false;
  SELECT_greenB = false;

  B_ChoiceCount++;
} 

//displays chosen character
void B_Choice() {
  if (cB[0] == color(255, 0, 0) && cB[1] == color(0, 255, 0) && cB[2] == color(0, 0, 255)) {
    B_Choice[B_ChoiceCount] = 1;
  }
  if (cB[0] == color(255, 0, 0) && cB[1] == color(0, 0, 255) && cB[2] == color(0, 255, 0)) {
    B_Choice[B_ChoiceCount] = 2;
  }
  if (cB[0] == color(0, 255, 0) && cB[1] == color(255, 0, 0) && cB[2] == color(0, 0, 255)) {
    B_Choice[B_ChoiceCount] = 3;
  }
  if (cB[0] == color(0, 255, 0) && cB[1] == color(0, 0, 255) && cB[2] == color(255, 0, 0)) {
    B_Choice[B_ChoiceCount] = 4;
  }
  if (cB[0] == color(0, 0, 255) && cB[1] == color(255, 0, 0) && cB[2] == color(0, 255, 0)) {
    B_Choice[B_ChoiceCount] = 5;
  }
  if (cB[0] == color(0, 0, 255) && cB[1] == color(0, 255, 0) && cB[2] == color(255, 0, 0)) {
    B_Choice[B_ChoiceCount] = 6;
  }
  //Displays 1st choice
  pushMatrix();
  translate(200, 250);
  scale(0.5);
  if (B_Choice[0] == 1) {
    showDefender(blue);
  }
  if (B_Choice[0] == 2) {
    showSwampy(blue);
  }
  if (B_Choice[0] == 3) {
    showStickRobo(blue);
  }
  if (B_Choice[0] == 4) {
    showFightBall(blue);
  }
  if (B_Choice[0] == 5) {
    showFlowerLady(blue);
  }
  if (B_Choice[0] == 6) {
    showOnion(blue);
  }
  popMatrix();

  //displays 2nd choice
  pushMatrix();
  translate(200, 450);
  scale(0.5);
  if (B_Choice[1] == 1) {
    showDefender(blue);
  }
  if (B_Choice[1] == 2) {
    showSwampy(blue);
  }
  if (B_Choice[1] == 3) {
    showStickRobo(blue);
  }
  if (B_Choice[1] == 4) {
    showFightBall(blue);
  }
  if (B_Choice[1] == 5) {
    showFlowerLady(blue);
  }
  if (B_Choice[1] == 6) {
    showOnion(blue);
  }
  popMatrix();

  //displays 3rd choice
  pushMatrix();
  translate(200, 650);
  scale(0.5);
  if (B_Choice[2] == 1) {
    showDefender(blue);
  }
  if (B_Choice[2] == 2) {
    showSwampy(blue);
  }
  if (B_Choice[2] == 3) {
    showStickRobo(blue);
  }
  if (B_Choice[2] == 4) {
    showFightBall(blue);
  }
  if (B_Choice[2] == 5) {
    showFlowerLady(blue);
  }
  if (B_Choice[2] == 6) {
    showOnion(blue);
  }
  popMatrix();
}

//**RED TEAM**
void SELECT_R() {

  if (keyPressed) {
    if (SELECT_tR < 3) {
      if (key == 'j') {
        cR[SELECT_tR] = color(255, 0, 0);
        if (!SELECT_redR) {
          SELECT_tR++;
        }
        SELECT_redR = true;
      }
      if (key == 'k') {
        cR[SELECT_tR] = color(0, 255, 0);
        if (!SELECT_greenR) {
          SELECT_tR++;
        }
        SELECT_greenR = true;
      }
      if (key == 'l') {
        cR[SELECT_tR] = color(0, 0, 255);
        if (!SELECT_blueR) {
          SELECT_tR++;
        }
        SELECT_blueR = true;
      }
    }
  }
  drawChosenR();
}

void drawChosenR() {
  noStroke();
  if (SELECT_tR > 0) {
    fill(cR[0]);
    ellipse(width-30, height-40, 20, 20);
  }
  if (SELECT_tR > 1) {
    fill(cR[1]);
    ellipse(width-60, height-40, 20, 20);
  }
  if (SELECT_tR > 2) {
    fill(cR[2]);
    ellipse(width-90, height-40, 20, 20);
  }
}

//resets process
void SELECT_Rreset() {
  SELECT_tR = 0;
  for (int i = 0; i < cR.length; i++) {
    cR[i] = 0;
  }
  SELECT_blueR = false;
  SELECT_redR = false;
  SELECT_greenR = false;

  R_ChoiceCount++;
} 

//displays chosen character
void R_Choice() {
  if (cR[0] == color(255, 0, 0) && cR[1] == color(0, 255, 0) && cR[2] == color(0, 0, 255)) {
    R_Choice[R_ChoiceCount] = 1;
  }
  if (cR[0] == color(255, 0, 0) && cR[1] == color(0, 0, 255) && cR[2] == color(0, 255, 0)) {
    R_Choice[R_ChoiceCount] = 2;
  }
  if (cR[0] == color(0, 255, 0) && cR[1] == color(255, 0, 0) && cR[2] == color(0, 0, 255)) {
    R_Choice[R_ChoiceCount] = 3;
  }
  if (cR[0] == color(0, 255, 0) && cR[1] == color(0, 0, 255) && cR[2] == color(255, 0, 0)) {
    R_Choice[R_ChoiceCount] = 4;
  }
  if (cR[0] == color(0, 0, 255) && cR[1] == color(255, 0, 0) && cR[2] == color(0, 255, 0)) {
    R_Choice[R_ChoiceCount] = 5;
  }
  if (cR[0] == color(0, 0, 255) && cR[1] == color(0, 255, 0) && cR[2] == color(255, 0, 0)) {
    R_Choice[R_ChoiceCount] = 6;
  }
  //Displays 1st choice
  pushMatrix();
  translate(width-200, 250);
  scale(0.5);
  if (R_Choice[0] == 1) {
    showDefender(red);
  }
  if (R_Choice[0] == 2) {
    showSwampy(red);
  }
  if (R_Choice[0] == 3) {
    showStickRobo(red);
  }
  if (R_Choice[0] == 4) {
    showFightBall(red);
  }
  if (R_Choice[0] == 5) {
    showFlowerLady(red);
  }
  if (R_Choice[0] == 6) {
    showOnion(red);
  }
  popMatrix();
  //displays 2nd choice
  pushMatrix();
  translate(width-200, 450);
  scale(0.5);
  if (R_Choice[1] == 1) {
    showDefender(red);
  }
  if (R_Choice[1] == 2) {
    showSwampy(red);
  }
  if (R_Choice[1] == 3) {
    showStickRobo(red);
  }
  if (R_Choice[1] == 4) {
    showFightBall(red);
  }
  if (R_Choice[1] == 5) {
    showFlowerLady(red);
  }
  if (R_Choice[1] == 6) {
    showOnion(red);
  }
  popMatrix();
  //displays 3rd choice
  pushMatrix();
  translate(width-200, 650);
  scale(0.5);
  if (R_Choice[2] == 1) {
    showDefender(red);
  }
  if (R_Choice[2] == 2) {
    showSwampy(red);
  }
  if (R_Choice[2] == 3) {
    showStickRobo(red);
  }
  if (R_Choice[2] == 4) {
    showFightBall(red);
  }
  if (R_Choice[2] == 5) {
    showFlowerLady(red);
  }
  if (R_Choice[2] == 6) {
    showOnion(red);
  }
  popMatrix();
}

//**CHARACTER CLASSES**

float hpDisplaypos = 120;
float menuDisplaypos_x = 250;
float menuDisplaypos_y = 100;
float menuDisplaypos_txt = 350;

class Defender {
  int hp = 5;
  int hp_max = 5;
  int atk = 1;
  int move = 1;
  int team;
  int position;

  Defender(int Team, int Pos) {
    team = Team;
    position = Pos;
  }

  void MenuDisplay() {
    textFont(names);
    if (team == blue) {
      fill(0, 0, 255);
    }
    if (team == red) {
      fill(255, 0, 0);
    }
    text("Ricardo", 200, 100);
    pushMatrix();
    translate(menuDisplaypos_x, height/2);
    showDefender(team);
    popMatrix();
    textFont(plain);
    fill(0);
    textAlign(LEFT);
    text("HP: " + hp, width-menuDisplaypos_txt, 150);
    text("ATTACK: " + atk, width-menuDisplaypos_txt, 200);
    text("MOVE: " + hp, width-menuDisplaypos_txt, 250);
    textFont(specialExtra);
    text("SPECIAL: Protection", width-menuDisplaypos_txt, 300);
    text("EXTRA: Shield Throw", width-menuDisplaypos_txt, 400);
    textFont(descriptions);
    text("Protects adjacent allies (-1 damage)", width-(menuDisplaypos_txt), 300, 300, 100);
    text("Throws shield for 2 damage. Cannot use Protection anymore.", width-(menuDisplaypos_txt), 400, 300, 200);
  }

  void hpDisplay() {
    float xpos = -50;
    pushMatrix();
    translate(hpDisplaypos*position, height-130);
    scale(0.2);
    showDefender(team);
    scale(1.8);
    for (int i = 0; i < hp_max; i++) {
      stroke(255, 0, 0);
      rect(xpos, 120, 5, 40);
      xpos += 20;
    }
    xpos = -50;
    for (int i = 0; i < hp; i++) {
      stroke(0, 255, 0);
      rect(xpos, 120, 5, 40);
      xpos += 20;
    }
    popMatrix();
  }
}

class Swampy {
  int hp = 2;
  int hp_max = 2;
  int atk = 3;
  int move = 2;
  int team;
  int position;

  Swampy(int Team, int Pos) {
    team = Team;
    position = Pos;
  }

  void MenuDisplay() {
    textFont(names);
    if (team == blue) {
      fill(0, 0, 255);
    }
    if (team == red) {
      fill(255, 0, 0);
    }
    text("María", 200, 100);
    pushMatrix();
    translate(200, height/2);
    scale(0.5);
    showSwampy(team);
    popMatrix();
    textFont(plain);
    fill(0);
    textAlign(LEFT);
    text("HP: " + hp, width-menuDisplaypos_txt, 150);
    text("ATTACK: " + atk, width-menuDisplaypos_txt, 200);
    text("MOVE: " + hp, width-menuDisplaypos_txt, 250);
    textFont(specialExtra);
    text("SPECIAL: Tail Slam", width-menuDisplaypos_txt, 300);
    text("EXTRA: Tail Flail", width-menuDisplaypos_txt, 400);
    textFont(descriptions);
    text("Does 3 damage. Adjacent foes take 1 damage.", width-(menuDisplaypos_txt), 300, 300, 100);
    text("Does 2 damage to all adjacent foes. Take 1 damage", width-(menuDisplaypos_txt), 400, 300, 200);
  }

  void hpDisplay() {
    float xpos = -50;
    pushMatrix();
    translate(hpDisplaypos*position, height-130);
    scale(0.2);
    showSwampy(team);
    scale(1.8);
    for (int i = 0; i < hp_max; i++) {
      stroke(255, 0, 0);
      rect(xpos, 120, 5, 40);
      xpos += 20;
    }
    xpos = -50;
    for (int i = 0; i < hp; i++) {
      stroke(0, 255, 0);
      rect(xpos, 120, 5, 40);
      xpos += 20;
    }
    popMatrix();
  }
}

class StickRobo {
  int hp = 1;
  int hp_max = 1;
  int atk = 2; //range is 2
  int move = 3;
  int team;
  int position;

  StickRobo(int Team, int Pos) {
    team = Team;
    position = Pos;
  }
  void MenuDisplay() {
    textFont(names);
    if (team == blue) {
      fill(0, 0, 255);
    }
    if (team == red) {
      fill(255, 0, 0);
    }
    text("L1uv14", 200, 100);
    pushMatrix();
    translate(200, height/2);
    scale(0.7);
    showStickRobo(team);
    popMatrix();
    textFont(plain);
    fill(0);
    textAlign(LEFT);
    text("HP: " + hp, width-menuDisplaypos_txt, 150);
    text("ATTACK: " + atk, width-menuDisplaypos_txt, 200);
    text("MOVE: " + hp, width-menuDisplaypos_txt, 250);
    textFont(specialExtra);
    text("SPECIAL: Hug", width-menuDisplaypos_txt, 300);
    text("EXTRA: Teleport", width-menuDisplaypos_txt, 400);
    textFont(descriptions);
    text("Deal 4 damage to 1 adjacent foe.", width-(menuDisplaypos_txt), 300, 300, 100);
    text("Move anywhere on the board.", width-(menuDisplaypos_txt), 400, 300, 200);
  }

  void hpDisplay() {
    float xpos = -50;
    pushMatrix();
    translate(hpDisplaypos*position, height-130);
    scale(0.2);
    showStickRobo(team);
    scale(1.8);
    for (int i = 0; i < hp_max; i++) {
      stroke(255, 0, 0);
      rect(xpos, 120, 5, 40);
      xpos += 20;
    }
    xpos = -50;
    for (int i = 0; i < hp; i++) {
      stroke(0, 255, 0);
      rect(xpos, 120, 5, 40);
      xpos += 20;
    }
    popMatrix();
  }
}

class FightBall {
  int hp = 4;
  int hp_max = 4;
  int atk = 2;
  int move = 2;
  int team;
  int position;

  FightBall(int Team, int Pos) {
    team = Team;
    position = Pos;
  }
  void MenuDisplay() {
    textFont(names);
    if (team == blue) {
      fill(0, 0, 255);
    }
    if (team == red) {
      fill(255, 0, 0);
    }
    text("Norm", 200, 100);
    pushMatrix();
    translate(200, height/2);
    scale(0.9);
    showFightBall(team);
    popMatrix();
    textFont(plain);
    fill(0);
    textAlign(LEFT);
    text("HP: " + hp, width-menuDisplaypos_txt, 150);
    text("ATTACK: " + atk, width-menuDisplaypos_txt, 200);
    text("MOVE: " + hp, width-menuDisplaypos_txt, 250);
    textFont(specialExtra);
    text("SPECIAL: N/A", width-menuDisplaypos_txt, 300);
    text("EXTRA: Sacrifice", width-menuDisplaypos_txt, 400);
    textFont(descriptions);
    //text("Protects adjacent allies (-1 damage)", width-(menuDisplaypos_txt), 300, 300, 100);
    text("Give remaining HP to adjacent ally. This character dies.", width-(menuDisplaypos_txt), 400, 300, 200);
  }

  void hpDisplay() {
    float xpos = -50;
    pushMatrix();
    translate(hpDisplaypos*position, height-130);
    scale(0.2);
    showFightBall(team);
    scale(1.8);
    for (int i = 0; i < hp_max; i++) {
      stroke(255, 0, 0);
      rect(xpos, 120, 5, 40);
      xpos += 20;
    }
    xpos = -50;
    for (int i = 0; i < hp; i++) {
      stroke(0, 255, 0);
      rect(xpos, 120, 5, 40);
      xpos += 20;
    }
    popMatrix();
  }
}

class FlowerLady {
  int hp = 5;
  int hp_max = 5;
  int atk = 0;
  int move = 1;
  int team;
  int position;


  FlowerLady(int Team, int Pos) {
    team = Team;
    position = Pos;
  }
  void MenuDisplay() {
    textFont(names);
    if (team == blue) {
      fill(0, 0, 255);
    }
    if (team == red) {
      fill(255, 0, 0);
    }
    text("Petuña", 200, 100);
    pushMatrix();
    translate(200, height/2.2);
    scale(0.85);
    showFlowerLady(team);
    popMatrix();
    textFont(plain);
    fill(0);
    textAlign(LEFT);
    text("HP: " + hp, width-menuDisplaypos_txt, 150);
    text("ATTACK: " + atk, width-menuDisplaypos_txt, 200);
    text("MOVE: " + hp, width-menuDisplaypos_txt, 250);
    textFont(specialExtra);
    text("SPECIAL: Perfume", width-menuDisplaypos_txt, 300);
    text("EXTRA: Stench", width-menuDisplaypos_txt, 400);
    textFont(descriptions);
    text("Increase ally's next attack by 2.", width-(menuDisplaypos_txt), 300, 300, 100);
    text("Reduce foe's next attack by 3.", width-(menuDisplaypos_txt), 400, 300, 200);
  }

  void hpDisplay() {
    float xpos = -50;
    pushMatrix();
    translate(hpDisplaypos*position, height-130);
    scale(0.2);
    showFlowerLady(team);
    scale(1.8);
    for (int i = 0; i < hp_max; i++) {
      stroke(255, 0, 0);
      rect(xpos, 120, 5, 40);
      xpos += 20;
    }
    xpos = -50;
    for (int i = 0; i < hp; i++) {
      stroke(0, 255, 0);
      rect(xpos, 120, 5, 40);
      xpos += 20;
    }
    popMatrix();
  }
}

class Onion {
  int hp = 3;
  int hp_max = 3;
  int atk = 1;
  int move = 0;
  int team;
  int position;


  Onion(int Team, int Pos) {
    team = Team;
    position = Pos;
  }
  void MenuDisplay() {
    textFont(names);
    if (team == blue) {
      fill(0, 0, 255);
    }
    if (team == red) {
      fill(255, 0, 0);
    }
    text("El Cebollón", 175, 100);
    pushMatrix();
    translate(200, height/2.2);
    showOnion(team);
    popMatrix();
    textFont(plain);
    fill(0);
    textAlign(LEFT);
    text("HP: " + hp, width-menuDisplaypos_txt, 150);
    text("ATTACK: " + atk, width-menuDisplaypos_txt, 200);
    text("MOVE: " + hp, width-menuDisplaypos_txt, 250);
    textFont(specialExtra);
    text("SPECIAL: Dig", width-menuDisplaypos_txt, 300);
    text("EXTRA: Onion Vibes (passive)", width-menuDisplaypos_txt, 400);
    textFont(descriptions);
    text("Move to an empty space (range: 2).", width-(menuDisplaypos_txt), 300, 300, 100);
    text("When attacked, deal 2 damage if attacker is adjacent. Ends after 2 turns.", width-(menuDisplaypos_txt), 400, 300, 200);
  }

  void hpDisplay() {
    float xpos = -50;
    pushMatrix();
    translate(hpDisplaypos*position, height-130);
    scale(0.2);
    showOnion(team);
    scale(1.8);
    for (int i = 0; i < hp_max; i++) {
      stroke(255, 0, 0);
      rect(xpos, 120, 5, 40);
      xpos += 20;
    }
    xpos = -50;
    for (int i = 0; i < hp; i++) {
      stroke(0, 255, 0);
      rect(xpos, 120, 5, 40);
      xpos += 20;
    }
    popMatrix();
  }
}

//Functions for displaying Character Sprites
void showDefender(int Team) {
  if (Team != 0 && Team != 1) {
    println("show function only takes 0 or 1");
    exit();
  }
  pushMatrix();
  if(Team == red){
   scale(-1,1); 
  }
  scale(0.5);  
  image(charaPictures[2+Team], 0, 0);
  popMatrix();
}

void showDefender_noShield(int Team) {
  if (Team != 0 && Team != 1) {
    println("show function only takes 0 or 1");
    exit();
  }
  pushMatrix();
  if(Team == red){
   scale(-1,1); 
  }
  scale(0.5);  
  image(charaPictures[0+Team], 0, 0);
  popMatrix();
}

void showSwampy(int Team){
  if (Team != 0 && Team != 1) {
    println("show function only takes 0 or 1");
    exit();
  }
  pushMatrix();
  if(Team == red){
   scale(-1,1); 
  }
  scale(0.5);  
  image(charaPictures[4+Team], 0, 0);
  popMatrix();
}

void showStickRobo(int Team){
  if (Team != 0 && Team != 1) {
    println("show function only takes 0 or 1");
    exit();
  }
  pushMatrix();
  if(Team == red){
   scale(-1,1); 
  }
  scale(0.4);  
  image(charaPictures[6+Team], 0, 0);
  popMatrix();
}

void showFightBall(int Team){
  if (Team != 0 && Team != 1) {
    println("show function only takes 0 or 1");
    exit();
  }
  pushMatrix();
  if(Team == red){
   scale(-1,1); 
  }
  scale(0.5);  
  image(charaPictures[8+Team], 0, 0);
  popMatrix();
}

void showFlowerLady(int Team){
  if (Team != 0 && Team != 1) {
    println("show function only takes 0 or 1");
    exit();
  }
  pushMatrix();
  if(Team == red){
   scale(-1,1); 
  }
  scale(0.4);  
  image(charaPictures[10+Team], 0, 0);
  popMatrix();
}

void showOnion(int Team){
  if (Team != 0 && Team != 1) {
    println("show function only takes 0 or 1");
    exit();
  }
  pushMatrix();
  if(Team == red){
   scale(-1,1); 
  }
  scale(0.4);  
  image(charaPictures[12+Team], 0, 0);
  popMatrix();
}
