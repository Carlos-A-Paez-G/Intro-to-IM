//All art was created by Carlos Páez (yes, me) using Aseprite. 
//Font "8bitOperatorPlus" downloaded from 1001freefonts.com/8-bit-operator.font

import processing.serial.*;

//Arduino communication variables
Serial Board;
int[] serialInArray = new int[2];    // Where we'll put what we receive (change the size of the array if needed
int serialCount = 0;                 // A count of how many bytes we receive
boolean firstContact = false;        // Whether we've heard from thea microcontroller
String BoardInput; //checks for LDR inputs

//general variables
int TITLE = 0;
int CHARA_SELECT = 1;
int GAME = 2;
int END_BLUEWIN = 3;
int END_REDWIN = 4;
int END_TIE = 5;
int TESTING = 100;
int gameState = TITLE;

int blue = 0;
int red = 1;

//Characters
Chara Dummy = new Chara(); //dummy used whenever there is a need for an empty character to fill something
Defender[] Defenders_B = new Defender[3];
Defender[] Defenders_R = new Defender[3];
Swampy[] Swampys_B = new Swampy[3];
Swampy[] Swampys_R = new Swampy[3];
StickRobo[] StickRobos_B = new StickRobo[3];
StickRobo[] StickRobos_R = new StickRobo[3];
FightBall[] FightBalls_B = new FightBall[3];
FightBall[] FightBalls_R = new FightBall[3];
FlowerLady[] FlowerLadys_B = new FlowerLady[3];
FlowerLady[] FlowerLadys_R = new FlowerLady[3];
Onion[] Onions_B = new Onion[3];
Onion[] Onions_R = new Onion[3];


//Fonts
PFont title;
PFont names;
PFont descriptions;
PFont plain;
PFont specialExtra;

//int[][] cells = new int[][]{
//  new int[] {1, 2, 3, 4}, 
//  new int[] {1, 2, 3, 4}, 
//};

String characters[] = {"DefenderN_B", "DefenderN_R", "Defender_B", "Defender_R", "Swampy_R", "Swampy_B", "StickRobo_B", "StickRobo_R", "FightBall_R", "FightBall_B", "FlowerLady_R", "FlowerLady_B", "Onion_B", "Onion_R"};
PImage charaPictures[] = new PImage[14];

int Title_t = 0; //timer for title
int Title_p = 1; //for title blinking message
int choice;

//CHARACTER_SELECT variables (Blue)
int SELECT_tB = 0; //counts blue team button presses in chara select
int Bx = 0;
int By = 0;
int B_ChoiceCount = 0;
int B_Choice[] = {0, 0, 0};
color cB[] = new color[3];
boolean SELECT_redB = false;
boolean SELECT_blueB = false;
boolean SELECT_greenB = false;
boolean B_positioned = false;

//CHARACTER_SELECT variables (Red)
int SELECT_tR = 0; //counts red team button presses in chara select
int Rx = 0;
int Ry = 0;
int R_ChoiceCount = 0;
int R_Choice[] = {0, 0, 0};
color cR[] = new color[3];
boolean SELECT_redR = false;
boolean SELECT_blueR = false;
boolean SELECT_greenR = false;
boolean R_positioned = false;

//CHARACTER_SELECT variables (etc)
int SELECT_tText = 0;
int SELECT_showText = 1;

//GAME variables
int turn = 0;
boolean endingTurn = false;

void setup() {
  size(800, 800);
  //initialize serial port
  Board = new Serial(this, Serial.list()[0], 9600);
  Board.clear();
  Board.bufferUntil('\n');

  //fullScreen();
  imageMode(CENTER);
  rectMode(CORNER);
  noStroke();

  //load images
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
  title = createFont("8bitOperatorPlus8-Bold.ttf", 64);
  plain = createFont("8bitOperatorPlus8-Regular.ttf", 28);
  names = createFont("8bitOperatorPlus8-Bold.ttf", 44);
  descriptions = createFont("8bitOperatorPlus8-Regular.ttf", 28);
  specialExtra = createFont("8bitOperatorPlus8-Bold.ttf", 28);

  //initialize null characters to avoid stupid errors
  for (int i = 0; i < Defenders_B.length; i++) {
    Defenders_B[i] = new Defender(blue, 0, 1000, 1000); 
    Defenders_R[i] = new Defender(red, 0, 1000, 1000); 
    Swampys_B[i] = new Swampy(blue, 0, 1000, 1000); 
    Swampys_R[i] = new Swampy(red, 0, 1000, 1000); 
    StickRobos_B[i] = new StickRobo(blue, 0, 1000, 1000);
    StickRobos_R[i] = new StickRobo(red, 0, 1000, 1000);
    FightBalls_B[i] = new FightBall(blue, 0, 1000, 1000);
    FightBalls_R[i] = new FightBall(red, 0, 1000, 1000);
    FlowerLadys_B[i] = new FlowerLady(blue, 0, 1000, 1000);
    FlowerLadys_R[i] = new FlowerLady(red, 0, 1000, 1000);
    Onions_B[i] = new Onion(blue, 0, 1000, 1000);
    Onions_R[i] = new Onion(red, 0, 1000, 1000);
  }
}

void draw() {
  BoardInput = Board.readStringUntil('\n');
 // println(BoardInput);
  background(255);

  if (gameState == TITLE) {
    //draws title of the game
    textFont(title);
    fill(0);
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

    //display message to prompt players to press button
    if (R_ChoiceCount == 3 && B_ChoiceCount == 3) {
      if (keyPressed) {
        if (key == 'y') {
          gameState = GAME;
        }
      }
      if (SELECT_showText == 1) {
        textFont(names);
        fill(0);
        text("PUSH BUTTON TO START", width/2, height/2);
      }
      //Make message blink
      SELECT_tText++;
      if (SELECT_tText == 100) {
        SELECT_showText *= -1;
        SELECT_tText = 0;
      }
    }
  }

  //************WHERE THE GAME HAPPENS***************
  if (gameState == GAME) {

    //Turn order manager -- lets the character act if it is their turn, adds one to turn counter otherwise
    //****REMEMBER TO CHANGE ORDER (menuDisplay -> Act)****
    for (int i = 0; i < Defenders_B.length; i++) {
      if (Defenders_B[i].position != 0 && turn == (i*2)+12) {
        Defenders_B[i].DefenderStart();
        Defenders_B[i].MenuDisplay();
        Defenders_B[i].Act();
        Defenders_B[i].extraAction();
      } else if (Defenders_B[i].position == 0 && turn == (i*2)+12) {
        Defenders_B[i].hp = 0;
        turn++;
      }
      if (Swampys_B[i].position != 0 && turn == (i*2)+7) {
        Swampys_B[i].MenuDisplay();
        Swampys_B[i].Act();
        Swampys_B[i].extraAction();
      } else if (Swampys_B[i].position == 0 && turn == (i*2)+7) {
        Swampys_B[i].hp = 0;
        turn++;
      }
      if (StickRobos_B[i].position != 0 && turn == (i*2)+19) {
        StickRobos_B[i].RoboStart();
        StickRobos_B[i].MenuDisplay();
        StickRobos_B[i].Act();
        StickRobos_B[i].extraAction();
      } else if (StickRobos_B[i].position == 0 && turn == (i*2)+19) {
        StickRobos_B[i].hp = 0;
        turn++;
      }
      if (FightBalls_B[i].position != 0 && turn == 2*i) {
        FightBalls_B[i].MenuDisplay();
        FightBalls_B[i].Act();
        FightBalls_B[i].extraAction();
      } else if (FightBalls_B[i].position == 0 && turn == 2*i) {
        FightBalls_B[i].hp = 0;
        turn++;
      }
      if (FlowerLadys_B[i].position != 0 && turn == (i*2)+24) {
        FlowerLadys_B[i].FlowerStart();
        FlowerLadys_B[i].MenuDisplay();
        FlowerLadys_B[i].Act();
        FlowerLadys_B[i].extraAction();
      } else if (FlowerLadys_B[i].position == 0 && turn == (i*2)+24) {
        FlowerLadys_B[i].hp = 0;
        turn++;
      }
      if (Onions_B[i].position != 0 && turn == (i*2)+31) {
        Onions_B[i].OnionStart();
        Onions_B[i].MenuDisplay();
        Onions_B[i].Act();
        Onions_B[i].extraAction();
      } else if (Onions_B[i].position == 0 && turn == (i*2)+31) {
        Onions_B[i].hp = 0;
        turn++;
      }
      if (Defenders_R[i].position != 0 && turn == (i*2)+13) {
        Defenders_R[i].DefenderStart();
        Defenders_R[i].MenuDisplay();
        Defenders_R[i].Act();
        Defenders_R[i].extraAction();
      } else if (Defenders_R[i].position == 0 && turn == (i*2)+13) {
        Defenders_R[i].hp = 0;
        turn++;
      }
      if (Swampys_R[i].position != 0 && turn == (i*2)+6) {
        Swampys_R[i].MenuDisplay();
        Swampys_R[i].Act();
        Swampys_R[i].extraAction();
      } else if (Swampys_R[i].position == 0 && turn == (i*2)+6) {
        Swampys_R[i].hp = 0;
        turn++;
      }
      if (StickRobos_R[i].position != 0 && turn == (i*2)+18) {
        StickRobos_R[i].RoboStart();
        StickRobos_R[i].MenuDisplay();
        StickRobos_R[i].Act();
        StickRobos_R[i].extraAction();
      } else if (StickRobos_R[i].position == 0 && turn == (i*2)+18) {
        StickRobos_R[i].hp = 0;
        turn++;
      }
      if (FightBalls_R[i].position != 0 && turn == (i*2)+1) {
        FightBalls_R[i].MenuDisplay();
        FightBalls_R[i].Act();
        FightBalls_R[i].extraAction();
      } else if (FightBalls_R[i].position == 0 && turn == (i*2)+1) {
        FightBalls_R[i].hp = 0;
        turn++;
      }
      if (FlowerLadys_R[i].position != 0 && turn == (i*2)+25) {
        FlowerLadys_R[i].FlowerStart();
        FlowerLadys_R[i].MenuDisplay();
        FlowerLadys_R[i].Act();
        FlowerLadys_R[i].extraAction();
      } else if (FlowerLadys_R[i].position == 0 && turn == (i*2)+25) {
        FlowerLadys_R[i].hp = 0;
        turn++;
      }
      if (Onions_R[i].position != 0 && turn == (i*2)+30) {
        Onions_R[i].OnionStart();
        Onions_R[i].MenuDisplay();
        Onions_R[i].Act();
        Onions_R[i].extraAction();
      } else if (Onions_R[i].position == 0 && turn == (i*2)+30) {
        Onions_R[i].hp = 0;
        turn++;
      }
    }

    //Allows to end turn by pressing y on keyboard
    if (keyPressed) {
      if (key == 'p' && !endingTurn) {
        turn++;
        endingTurn = true;
      }
    }

    //resets turns
    if (turn == 36) {
      for (int i = 0; i < Defenders_B.length; i++) {
        if (Defenders_B[i].position != 0) {
          Defenders_B[i].moved = false;
          Defenders_B[i].DefenderStarted = false;
        }
        if (Swampys_B[i].position != 0) {
          Swampys_B[i].moved = false;
        }
        if (StickRobos_B[i].position != 0) {
          StickRobos_B[i].moved = false;
          StickRobos_B[i].RoboStarted = false;
        }
        if (FightBalls_B[i].position != 0) {
          FightBalls_B[i].moved = false;
        }
        if (FlowerLadys_B[i].position != 0) {
          FlowerLadys_B[i].moved = false;
          FlowerLadys_B[i].FlowerStarted = false;
        }
        if (Onions_B[i].position != 0) {
          Onions_B[i].moved = false;
          Onions_B[i].OnionStarted = false;
        }
        if (Defenders_R[i].position != 0) {
          Defenders_R[i].moved = false;
          Defenders_B[i].DefenderStarted = false;
        }
        if (Swampys_R[i].position != 0) {
          Swampys_R[i].moved = false;
        }
        if (StickRobos_R[i].position != 0) {
          StickRobos_R[i].moved = false;
          StickRobos_R[i].RoboStarted = false;
        }
        if (FightBalls_R[i].position != 0) {
          FightBalls_R[i].moved = false;
        }
        if (FlowerLadys_R[i].position != 0) {
          FlowerLadys_R[i].moved = false;
          FlowerLadys_R[i].FlowerStarted = false;
        }
        if (Onions_R[i].position != 0) {
          Onions_R[i].moved = false;
          Onions_R[i].OnionStarted = false;
        }
      }
      turn = 0;
    }


    //**DISPLAY HP**
    for (int i = 0; i < Defenders_B.length; i++) {
      if (Defenders_B[i].position != 0) {
        Defenders_B[i].hpDisplay();
      }
      if (Swampys_B[i].position != 0) {
        Swampys_B[i].hpDisplay();
      }
      if (StickRobos_B[i].position != 0) {
        StickRobos_B[i].hpDisplay();
      }
      if (FightBalls_B[i].position != 0) {
        FightBalls_B[i].hpDisplay();
      }
      if (FlowerLadys_B[i].position != 0) {
        FlowerLadys_B[i].hpDisplay();
      }
      if (Onions_B[i].position != 0) {
        Onions_B[i].hpDisplay();
      }
      if (Defenders_R[i].position != 0) {
        Defenders_R[i].hpDisplay();
      }
      if (Swampys_R[i].position != 0) {
        Swampys_R[i].hpDisplay();
      }
      if (StickRobos_R[i].position != 0) {
        StickRobos_R[i].hpDisplay();
      }
      if (FightBalls_R[i].position != 0) {
        FightBalls_R[i].hpDisplay();
      }
      if (FlowerLadys_R[i].position != 0) {
        FlowerLadys_R[i].hpDisplay();
      }
      if (Onions_R[i].position != 0) {
        Onions_R[i].hpDisplay();
      }
    }

    //*ends game and chooses winner*
    int deaths_B = 0;
    int deaths_R = 0;
    for (int i = 0; i < Defenders_B.length; i++) {
      if (Defenders_B[i].hp == 0 && Swampys_B[i].hp == 0 && StickRobos_B[i].hp == 0 && FightBalls_B[i].hp == 0 && FlowerLadys_B[i].hp == 0 && Onions_B[i].hp == 0) {
        deaths_B++;
        println("blue deaths: " + deaths_B);
      }
      if (Defenders_R[i].hp == 0 && Swampys_R[i].hp == 0 && StickRobos_R[i].hp == 0 && FightBalls_R[i].hp == 0 && FlowerLadys_R[i].hp == 0 && Onions_R[i].hp == 0) {
        deaths_R++;
        println("red deaths: " + deaths_R);
      }
      if (deaths_B >= 3 && deaths_R <3) {
        gameState = END_REDWIN;
      }
      if (deaths_R >= 3 && deaths_B <3) {
        gameState = END_BLUEWIN;
      }
      if (deaths_R >= 3 && deaths_B >= 3) {
        gameState = END_TIE;
      }
    }
  }
  //*********VICTORY SCREENS*************
  if (gameState == END_BLUEWIN) {
    textFont(title);
    fill(0, 0, 255);
    text("BLUE TEAM WINS!", width/2, height/2);
    println("WIN BLUE");
    if (keyPressed) {
      if (key == 'n') {
        gameState = TITLE;
      }
    }
  }
  if (gameState == END_REDWIN) {
    textFont(title);
    fill(255, 0, 0);
    text("RED TEAM WINS!", width/2, height/2);
    println("WIN RED");
    if (keyPressed) {
      if (key == 'n') {
        gameState = TITLE;
      }
    }
  }
  if (gameState == END_TIE) {
    textFont(title);
    fill(0);
    text("IT'S A TIE!", width/2, height/2);
    if (keyPressed) {
      if (key == 'n') {
        gameState = TITLE;
      }
    }
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

  //helps in skipping turns
  if (gameState == GAME) {
    endingTurn = false;
  }
}

//CHARACTER_SELECT functions

//**BLUE TEAM**
void SELECT_B() {
  //Selects characters using Arduino buttons
  if (SELECT_tB < 3) {
    if (BoardInput != null) {
      BoardInput = trim(BoardInput);
      if (BoardInput.equals("R1")) {
        cB[SELECT_tB] = color(255, 0, 0);
        if (!SELECT_redB) {
          SELECT_tB++;
        }
        SELECT_redB = true;
      }
      if (BoardInput.equals("G1")) {
        cB[SELECT_tB] = color(0, 255, 0);
        if (!SELECT_greenB) {
          SELECT_tB++;
        }
        SELECT_greenB = true;
      }
      if (BoardInput.equals("B1")) {
        cB[SELECT_tB] = color(0, 0, 255);
        if (!SELECT_blueB) {
          SELECT_tB++;
        }
        SELECT_blueB = true;
      }
    }
  }
  //Resets the selection when button is released
  if (SELECT_tB == 3 && BoardInput == null) {
    SELECT_Breset();
  }

  //Selects characters using keyboard
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
  Bx = 0;
  By = 0;
  B_ChoiceCount++;
} 

//displays chosen character (and prepares to initalize character..?)
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

  //Displays choices and initializes characters
  for (int i = 0; i < Defenders_B.length; i++) {
    pushMatrix();
    translate(200, 250+(200*i));
    scale(0.5);
    if (B_Choice[i] == 1) {
      showDefender(blue);
      Defenders_B[i] = new Defender(blue, i+1, Bx, By);
    }
    if (B_Choice[i] == 2) {
      showSwampy(blue);
      Swampys_B[i] = new Swampy(blue, i+1, Bx, By);
    }
    if (B_Choice[i] == 3) {
      showStickRobo(blue);
      StickRobos_B[i] = new StickRobo(blue, i+1, Bx, By);
    }
    if (B_Choice[i] == 4) {
      showFightBall(blue);
      FightBalls_B[i] = new FightBall(blue, i+1, Bx, By);
    }
    if (B_Choice[i] == 5) {
      showFlowerLady(blue);
      FlowerLadys_B[i] = new FlowerLady(blue, i+1, Bx, By);
    }
    if (B_Choice[i] == 6) {
      showOnion(blue);
      Onions_B[i] = new Onion(blue, i+1, Bx, By);
    }
    popMatrix();
  }
}

void choosePosition_B() {
  if (keyPressed) { //replace with LDR input from Arduino
    if (key == 'q') {
      Bx = 1;
    }
    if (key == 'w') {
      Bx = 2;
    }
    if (key == 'e') {
      Bx = 3;
    }
    if (key == 'r') {
      Bx = 4;
    }
    if (key == 't') {
      By = 1;
    }
    if (key == 'y') {
      By = 2;
    }
    if (key == 'u') {
      By = 3;
    }
    if (key == 'i') {
      By = 4;
    }
  }
  if (Bx == 1 && By > 0) {
    B_positioned = true;
  }
}

void posReset_B() {
  Bx = 0;
  By = 0;
}

//**RED TEAM**
void SELECT_R() {
//Selects characters using Arduino buttons
  if (SELECT_tR < 3) {
    if (BoardInput != null) {
      BoardInput = trim(BoardInput);
      if (BoardInput.equals("R2")) {
        cR[SELECT_tR] = color(255, 0, 0);
        if (!SELECT_redR) {
          SELECT_tR++;
        }
        SELECT_redR = true;
      }
      if (BoardInput.equals("G2")) {
        cR[SELECT_tR] = color(0, 255, 0);
        if (!SELECT_greenR) {
          SELECT_tR++;
        }
        SELECT_greenR = true;
      }
      if (BoardInput.equals("B2")) {
        cR[SELECT_tR] = color(0, 0, 255);
        if (!SELECT_blueR) {
          SELECT_tR++;
        }
        SELECT_blueR = true;
      }
    }
  }
  //Resets the selection when button is released
  if (SELECT_tR == 3 && BoardInput == null) {
    SELECT_Rreset();
  }
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
  for (int i = 0; i < Defenders_B.length; i++) {
    pushMatrix();
    translate(width-200, 250+(i*200));
    scale(0.5);
    if (R_Choice[i] == 1) {
      showDefender(red);
      Defenders_R[i] = new Defender(red, i+1, Rx, Ry);
    }
    if (R_Choice[i] == 2) {
      showSwampy(red);
      Swampys_R[i] = new Swampy(red, i+1, Rx, Ry);
    }
    if (R_Choice[i] == 3) {
      showStickRobo(red);
      StickRobos_R[i] = new StickRobo(red, i+1, Rx, Ry);
    }
    if (R_Choice[i] == 4) {
      showFightBall(red);
      FightBalls_R[i] = new FightBall(red, i+1, Rx, Ry);
    }
    if (R_Choice[i] == 5) {
      showFlowerLady(red);
      FlowerLadys_R[i] = new FlowerLady(red, i+1, Rx, Ry);
    }
    if (R_Choice[i] == 6) {
      showOnion(red);
      Onions_R[i] = new Onion(red, i+1, Rx, Ry);
    }
    popMatrix();
  }
}

//**CHARACTER CLASSES**


/*movement prediction array size formula
 
 PVector[] predictions = new PVector[4*(move((1+move)/2)];
 PVector locationCheck = new PVector(0,0);
 PVector locationCurrent = new PVector(cellx, celly);
 int placeCount = 0;
 for(int x = 1; x <= 4; x++){
 for(int y = 1; y <= 4; y++){
 locationCheck.x = x;
 locationCheck.y = y;
 PVector dist = locationCurrent.sub(locationCheck);
 if(abs(cellx-locationCheck.x)+abs(celly-locationCheck.y))<=move){
 //light up corresponding LEDs 
 }
 }
 }
 */

float hpDisplaypos = 120;
float menuDisplaypos_x = 250;
float menuDisplaypos_y = 100;
float menuDisplaypos_txt = 350;

class Chara {
  int hp;
  int hp_max;
  int atk;
  int move;
  int def = 0;
  int range;
  int team;
  int position; //which member of the team is it (1st, 2nd, 3rd)

  //position on the board
  int cellx;
  int celly;

  boolean moving;
  boolean moved;
  //boolean moveCheck = false;
  boolean attacking;
  boolean attackStart = false;
  boolean attackCheck = false;
  boolean special;
  boolean extra;
  boolean usedExtra = false;
  boolean contactMade; 

  int missed_t = 0;

  //for targetting (moving and attacking)
  int newx = 0;
  int newy = 0;

  void Act() {
    if (hp > 0) {
      if (keyPressed) {
        if (key == 'z') { //replace with button input from Arduino
          moving = true;
        }
        if (key == 'x') {
          attacking = true;
        }
      }
      if (moving && !attacking && !special && !moved) {
        if (move == 0) {
          moved = true;
        }
        movement();
      }
      if (attacking && !moving && !special) {
        Attack();
        attackStart = true;
      }

      //ends turn
      if (!attacking && !special && !extra && attackStart) {
        turn++;
        newx = 0;
        newy = 0;
        attackStart = false;
        attackCheck = false;
      }
    }
    //ends turn if dead
    if (hp <= 0) {
      hp = 0;
      turn++;
    }
  }
  void movement() {
    if (move == 0) {
      moved = true; 
      moving = false;
    }
    boolean collided = false;
    //send signal to X+-m and Y+-m
    textFont(title);
    textAlign(CENTER);
    rectMode(CENTER);
    fill(255, 0, 0);
    text("Move your character on the board", width/2, height/2, width/2, height/2);
    fill(0, 0, 0, 50);
    rect(width/2, height/2, width, height);
    keyboardCheck();
    BoardCheck();

    //prevents overlap. also prevents moving onto same spot
    for (int i = 0; i < Defenders_B.length; i++) {
      if (Defenders_B[i].cellx == newx && Defenders_B[i].celly == newy) {
        collided = true;
      }
      if (Defenders_R[i].cellx == newx && Defenders_R[i].celly == newy) {
        collided = true;
      }
      if (Swampys_B[i].cellx == newx && Swampys_B[i].celly == newy) {
        collided = true;
      }
      if (Swampys_R[i].cellx == newx && Swampys_R[i].celly == newy) {
        collided = true;
      }
      if (StickRobos_B[i].cellx == newx && StickRobos_B[i].celly == newy) {
        collided = true;
      }
      if (StickRobos_R[i].cellx == newx && StickRobos_R[i].celly == newy) {
        collided = true;
      }
      if (FightBalls_B[i].cellx == newx && FightBalls_B[i].celly == newy) {
        collided = true;
      }
      if (FightBalls_R[i].cellx == newx && FightBalls_R[i].celly == newy) {
        collided = true;
      }
      if (FlowerLadys_B[i].cellx == newx && FlowerLadys_B[i].celly == newy) {
        collided = true;
      }
      if (FlowerLadys_R[i].cellx == newx && FlowerLadys_R[i].celly == newy) {
        collided = true;
      }
      if (Onions_B[i].cellx == newx && Onions_B[i].celly == newy) {
        collided = true;
      }
      if (Onions_R[i].cellx == newx && Onions_R[i].celly == newy) {
        collided = true;
      }
    }
    if ((abs(cellx-newx)+abs(celly-newy))<=move && (newx != 0 && newy != 0) && contactMade && !collided) {
      cellx = newx;
      celly = newy;
      moving = false;
      moved = true;
      contactMade = false;
      newx = 0;
      newy = 0;

      //this allows red team to come in from the x=4 side of board
    } else if ((this.team == red && cellx == 0 && celly == 0) && (abs(cellx+5-newx)<=move && (newx != 0 && newy != 0) && contactMade && !collided)) {
      cellx = newx;
      celly = newy;
      moving = false;
      moved = true;
      contactMade = false;
      turn++;
      newx = 0;
      newy = 0;
      //this allows blue team to come in from the x=1 side of board
    } else if ((this.team == blue && cellx == 0 && celly == 0) && (abs(cellx-newx)<=move && (newx != 0 && newy != 0) && contactMade && !collided)) {
      cellx = newx;
      celly = newy;
      moving = false;
      moved = true;
      contactMade = false;
      turn++;
      newx = 0;
      newy = 0;
    }
    //allows you to press "y" to exit movement (to avoid softlocking)
    if (keyPressed) {
      if (key == 'y') {
        moving = false;
        moved = true;
        contactMade = false;
        newx = 0;
        newy = 0;
      }
    }
  }

  void Attack() {
    textFont(title);
    textAlign(CENTER);
    rectMode(CENTER);
    fill(255, 0, 0);
    text("Lift the character you want to attack", width/2, height/2, width/2, height/2);
    fill(0, 0, 0, 50);
    rect(width/2, height/2, width, height);
    keyboardCheck();
    if (contactMade && (newx != 0 && newy != 0) && abs(cellx-newx)+abs(celly-newy)<=range) {
      //check for each possible character to see if the x,y matches
      for (int i = 0; i < 3; i++) {
        if (Defenders_B[i].cellx == newx && Defenders_B[i].celly == newy) {
          takeDamage(Defenders_B[i]);
          println("hit blue D and now " + Defenders_B[i].hp);
        }
        if (Defenders_R[i].cellx == newx && Defenders_R[i].celly == newy) {
          takeDamage(Defenders_R[i]);
        }
        if (Swampys_B[i].cellx == newx && Swampys_B[i].celly == newy) {
          takeDamage(Swampys_B[i]);
        }
        if (Swampys_R[i].cellx == newx && Swampys_R[i].celly == newy) {
          takeDamage(Swampys_R[i]);
        }
        if (StickRobos_B[i].cellx == newx && StickRobos_B[i].celly == newy) {
          takeDamage(StickRobos_B[i]);
        }
        if (StickRobos_R[i].cellx == newx && StickRobos_R[i].celly == newy) {
          takeDamage(StickRobos_R[i]);
        }
        if (FightBalls_B[i].cellx == newx && FightBalls_B[i].celly == newy) {
          takeDamage(FightBalls_B[i]);
        }
        if (FightBalls_R[i].cellx == newx && FightBalls_R[i].celly == newy) {
          takeDamage(FightBalls_R[i]);
        }
        if (FlowerLadys_B[i].cellx == newx && FlowerLadys_B[i].celly == newy) {
          takeDamage(FlowerLadys_B[i]);
        }
        if (FlowerLadys_R[i].cellx == newx && FlowerLadys_R[i].celly == newy) {
          takeDamage(FlowerLadys_R[i]);
        }
        if (Onions_B[i].cellx == newx && Onions_B[i].celly == newy) {
          takeDamage(Onions_B[i]);
          if (this.range == 1) {
            this.hp -= 2;
          }
        }
        if (Onions_R[i].cellx == newx && Onions_R[i].celly == newy) {
          takeDamage(Onions_R[i]);
          if (this.range == 1) {
            this.hp -= 2;
          }
        }
      }
      //Ends turn if attack missed
      if (!attackCheck && newx != 0 && newy != 0) {
        newx = 0;
        newy = 0;         
        textFont(title);
        textAlign(CENTER);
        rectMode(CENTER);
        fill(255, 0, 0);
        text("Attack Missed!", width/2, height/2, width/2, height-height/4);
        fill(0, 0, 0, 50);
        rect(width/2, height/2, width, height);
        println(missed_t);
        missed_t++;
        if (missed_t > 10) {
          attacking = false;
          extra = false;
          special = false;
        }
      }
    }
  }

  void takeDamage(Chara C) {
    //if (atk-C.def > 0) {
    C.hp -= atk-C.def;
    //}
    println("attacked");
    newx = 0;
    newy = 0;
    attackCheck = true;
    attacking = false;
    extra = false;
    special = false;
  }
  //for checking input from LDRs

  void BoardCheck() {
          println("hey");
    if (BoardInput != null) {
      BoardInput = trim(BoardInput);
      if (BoardInput.equals("A - 1")) {
        newx = 1;
        newy = 1;
        contactMade = true;
      } else if (BoardInput.equals("A - 2")) {
        newx = 1;
        newy = 2;
        contactMade = true;
      } else if (BoardInput.equals("A - 3")) {
        newx = 1;
        newy = 3;
        contactMade = true;
      } else if (BoardInput.equals("A - 4")) {
        newx = 1;
        newy = 4;
        contactMade = true;
      }
    }
  }

  //for debugging, or controller failure
  void keyboardCheck() {
    if (keyPressed) { //replace with LDR input from Arduino
      if (key == 'q') {
        newx = 1;
        contactMade = true;
      }
      if (key == 'w') {
        newx = 2;
        contactMade = true;
      }
      if (key == 'e') {
        newx = 3;
        contactMade = true;
      }
      if (key == 'r') {
        newx = 4;
        contactMade = true;
      }
      if (key == 'a') {
        newy = 1;
        contactMade = true;
      }
      if (key == 's') {
        newy = 2;
        contactMade = true;
      }
      if (key == 'd') {
        newy = 3;
        contactMade = true;
      }
      if (key == 'f') {
        newy = 4;
        contactMade = true;
      }
    }
  }

  void displayLocation() {
    textFont(plain);
    textAlign(LEFT);
    fill(0);
    if (cellx == 1) {
      text("A - " + celly, width-200, 50);
    } else if (cellx == 2) {
      text("B - " + celly, width-200, 50);
    } else if (cellx == 3) {
      text("C - " + celly, width-200, 50);
    } else if (cellx == 4) {
      text("D - " + celly, width-200, 50);
    }
  }

  void mini_displayLocation() {
    textFont(plain);
    textAlign(CENTER);
    fill(0);
    text(cellx + " - " + celly, 0, 75);
  }

  void mini_protected() {
    if (def > 0) {
      textFont(plain);
      textAlign(CENTER);
      fill(0);
      text("+" + def + "def", 0, 125);
    }
  }
}

//**Functions for displaying Character Sprites**
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

class Defender extends Chara {
  Chara Protected = Dummy;
  boolean shieldOn;
  boolean DefenderStarted = false;

  Defender(int Team, int Pos, int CellX, int CellY) { 
    team = Team;
    position = Pos;
    cellx = CellX;
    celly = CellY;
    moving = false;
    moved = false;
    contactMade = false;
    attacking = false;
    special = false;
    hp = 4;
    hp_max = 4;
    atk = 1;
    move = 1;
    range = 1;
    newx = 0;
    newy = 0;
    shieldOn = true;
  }

  void MenuDisplay() {
    textFont(names);
    if (team == blue) {
      fill(0, 0, 255);
    }
    if (team == red) {
      fill(255, 0, 0);
    }
    rectMode(CORNER);
    displayLocation();
    text("Ricardo " + position, 200, 100);
    pushMatrix();
    translate(menuDisplaypos_x, height/2);
    if (shieldOn) {
      showDefender(team);
    } else if (!shieldOn) {
      showDefender_noShield(team);
    }
    popMatrix();
    textFont(plain);
    fill(0);
    textAlign(LEFT);
    text("HP: " + hp, width-menuDisplaypos_txt, 150);
    text("ATTACK: " + atk, width-menuDisplaypos_txt, 200);
    text("MOVE: " + move, width-menuDisplaypos_txt, 250);
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
    if (team == blue) {
      translate(hpDisplaypos*position, height-130);
    }
    if (team == red) {
      translate(hpDisplaypos*(position+3), height-130);
    }
    mini_displayLocation();
    mini_protected();
    scale(0.2);
    if (hp > 0) {
      if (shieldOn) {
        showDefender(team);
      } else if (!shieldOn) {
        showDefender_noShield(team);
      }
    }
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

  void DefenderStart() {
    if (!DefenderStarted) {
      Protected.def = 0;
      println(Protected.def);
      Protected = Dummy;
      range = 1;
      DefenderStarted = true;
    }
  }

//**DOES SPECIAL AND EXTRA MOVES**
  void extraAction() {
    if (keyPressed) {
      if (key == 'c') {
        if (!moving) {
          special = true;
        } else if (moving && !usedExtra) {
          extra = true;
        }
      }
    }
    if (!attacking && !moving && special) {
      Protection();
      attackStart = true;
    }
    if (!attacking && !special && !moving && extra) {
      ShieldThrow();
      usedExtra = true;
      attackStart = true;
    }
  }

  void Protection() {
    textFont(title);
    textAlign(CENTER);
    rectMode(CENTER);
    fill(255, 0, 0);
    text("Lift the character you want to protect", width/2, height/2, width/2, height/2);
    fill(0, 0, 0, 50);
    rect(width/2, height/2, width, height);
    keyboardCheck();
    //check for each possible character to see if the x,y matches
    for (int i = 0; i < Defenders_B.length; i++) {
      if (Defenders_B[i].cellx == newx && Defenders_B[i].celly == newy) {
        protect(Defenders_B[i]);
      }
      if (Defenders_R[i].cellx == newx && Defenders_R[i].celly == newy) {
        protect(Defenders_R[i]);
      }
      if (Swampys_B[i].cellx == newx && Swampys_B[i].celly == newy) {
        protect(Swampys_B[i]);
      }
      if (Swampys_R[i].cellx == newx && Swampys_R[i].celly == newy) {
        protect(Swampys_R[i]);
      }
      if (StickRobos_B[i].cellx == newx && StickRobos_B[i].celly == newy) {
        protect(StickRobos_B[i]);
      }
      if (StickRobos_R[i].cellx == newx && StickRobos_R[i].celly == newy) {
        protect(StickRobos_R[i]);
      }
      if (FightBalls_B[i].cellx == newx && FightBalls_B[i].celly == newy) {
        protect(FightBalls_B[i]);
      }
      if (FightBalls_R[i].cellx == newx && FightBalls_R[i].celly == newy) {
        protect(FightBalls_R[i]);
      }
      if (FlowerLadys_B[i].cellx == newx && FlowerLadys_B[i].celly == newy) {
        protect(FlowerLadys_B[i]);
      }
      if (FlowerLadys_R[i].cellx == newx && FlowerLadys_R[i].celly == newy) {
        protect(FlowerLadys_R[i]);
      }
      if (Onions_B[i].cellx == newx && Onions_B[i].celly == newy) {
        protect(Onions_B[i]);
      }
      if (Onions_R[i].cellx == newx && Onions_R[i].celly == newy) {
        protect(Onions_R[i]);
      }
    }
  }
  void protect(Chara C) {
    C.def += 1;
    Protected = C;
    special = false;
  }

  void ShieldThrow() {
    range = 2;
    shieldOn = false;
    Attack();
  }
}

class FightBall extends Chara {

  FightBall(int Team, int Pos, int CellX, int CellY) {
    team = Team;
    position = Pos;
    cellx = CellX;
    celly = CellY;
    moving = false;
    moved = false;
    contactMade = false;
    attacking = false;
    special = false;
    hp = 4;
    hp_max = 4;
    atk = 2;
    move = 2;
    range = 1;
    newx = 0;
    newy = 0;
  }
  void MenuDisplay() {
    textFont(names);
    if (team == blue) {
      fill(0, 0, 255);
    }
    if (team == red) {
      fill(255, 0, 0);
    }
    rectMode(CORNER);
    displayLocation();
    text("Norm " + position, 200, 100);
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
    text("MOVE: " + move, width-menuDisplaypos_txt, 250);
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
    if (team == blue) {
      translate(hpDisplaypos*position, height-130);
    }
    if (team == red) {
      translate(hpDisplaypos*(position+3), height-130);
    }
    mini_displayLocation();
    mini_protected();
    scale(0.2);
    if (hp > 0) {
      showFightBall(team);
    }
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

  void extraAction() {
    if (keyPressed) {
      if (key == 'c') {
        if (moving && !usedExtra) {
          extra = true;
        }
      }
    }
    if (!attacking && !special && !moving && extra) {
      Sacrifice();
      attackStart = true;
    }
  }

  void Sacrifice() {
    textFont(title);
    textAlign(CENTER);
    rectMode(CENTER);
    fill(255, 0, 0);
    text("Lift the character you want to sacrifice for", width/2, height/2, width/2, height/2);
    fill(0, 0, 0, 50);
    rect(width/2, height/2, width, height);
    keyboardCheck(); 
    //check for each possible character to see if the x,y matches
    for (int i = 0; i < Defenders_B.length; i++) {
      if (Defenders_B[i].cellx == newx && Defenders_B[i].celly == newy) {
        giveLife(Defenders_B[i]);
      }
      if (Defenders_R[i].cellx == newx && Defenders_R[i].celly == newy) {
        giveLife(Defenders_R[i]);
      }
      if (Swampys_B[i].cellx == newx && Swampys_B[i].celly == newy) {
        giveLife(Swampys_B[i]);
      }
      if (Swampys_R[i].cellx == newx && Swampys_R[i].celly == newy) {
        giveLife(Swampys_R[i]);
      }
      if (StickRobos_B[i].cellx == newx && StickRobos_B[i].celly == newy) {
        giveLife(StickRobos_B[i]);
      }
      if (StickRobos_R[i].cellx == newx && StickRobos_R[i].celly == newy) {
        giveLife(StickRobos_R[i]);
      }
      if (FightBalls_B[i].cellx == newx && FightBalls_B[i].celly == newy) {
        giveLife(FightBalls_B[i]);
      }
      if (FightBalls_R[i].cellx == newx && FightBalls_R[i].celly == newy) {
        giveLife(FightBalls_R[i]);
      }
      if (FlowerLadys_B[i].cellx == newx && FlowerLadys_B[i].celly == newy) {
        giveLife(FlowerLadys_B[i]);
      }
      if (FlowerLadys_R[i].cellx == newx && FlowerLadys_R[i].celly == newy) {
        giveLife(FlowerLadys_R[i]);
      }
      if (Onions_B[i].cellx == newx && Onions_B[i].celly == newy) {
        giveLife(Onions_B[i]);
      }
      if (Onions_R[i].cellx == newx && Onions_R[i].celly == newy) {
        giveLife(Onions_R[i]);
      }
    }
  }

  void giveLife(Chara C) {
    C.hp += this.hp; 
    hp = 0;
    extra = false;
  }
}

class FlowerLady extends Chara {
  Chara Strengthened = Dummy;
  Chara Weakened = Dummy;
  boolean FlowerStarted = false;

  FlowerLady(int Team, int Pos, int CellX, int CellY) {
    team = Team;
    position = Pos;
    cellx = CellX;
    celly = CellY;
    moving = false;
    moved = false;
    contactMade = false;
    attacking = false;
    special = false;
    hp = 5;
    hp_max = 5;
    atk = 0;
    move = 1;
    range = 2;
    newx = 0;
    newy = 0;
  }
  void MenuDisplay() {
    textFont(names);
    if (team == blue) {
      fill(0, 0, 255);
    }
    if (team == red) {
      fill(255, 0, 0);
    }
    rectMode(CORNER);
    displayLocation();
    text("Petuña " + position, 200, 100);
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
    text("MOVE: " + move, width-menuDisplaypos_txt, 250);
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
    if (team == blue) {
      translate(hpDisplaypos*position, height-130);
    }
    if (team == red) {
      translate(hpDisplaypos*(position+3), height-130);
    }    
    mini_displayLocation();
    mini_protected();
    scale(0.2);
    if (hp > 0) {
      showFlowerLady(team);
    }
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

  void FlowerStart() {
    if (!FlowerStarted) {
      println("hey");
      Strengthened.atk -= 2;
      Strengthened = Dummy;
      Weakened.atk += 3;
      Weakened = Dummy;
      FlowerStarted = true;
    }
  }

  void extraAction() {
    if (keyPressed) {
      if (key == 'c') {
        if (!moving) {
          special = true;
        } else if (moving && !usedExtra) {
          extra = true;
        }
      }
    }
    if (!attacking && !moving && special) {
      Perfume();
      attackStart = true;
    }
    if (!attacking && !special && !moving && extra) {
      BadBreath();
      attackStart = true;
    }
  }

  void Perfume() {
    textFont(title);
    textAlign(CENTER);
    rectMode(CENTER);
    fill(255, 0, 0);
    text("Lift the character you want to perfume", width/2, height/2, width/2, height/2);
    fill(0, 0, 0, 50);
    rect(width/2, height/2, width, height);
    keyboardCheck(); 
    //check for each possible character to see if the x,y matches
    if (contactMade && (newx != 0 && newy != 0) && abs(cellx-newx)+abs(celly-newy)<=range) {
      for (int i = 0; i < Defenders_B.length; i++) {
        if (Defenders_B[i].cellx == newx && Defenders_B[i].celly == newy) {
          givePerfume(Defenders_B[i]);
        }
        if (Defenders_R[i].cellx == newx && Defenders_R[i].celly == newy) {
          givePerfume(Defenders_R[i]);
        }
        if (Swampys_B[i].cellx == newx && Swampys_B[i].celly == newy) {
          givePerfume(Swampys_B[i]);
        }
        if (Swampys_R[i].cellx == newx && Swampys_R[i].celly == newy) {
          givePerfume(Swampys_R[i]);
        }
        if (StickRobos_B[i].cellx == newx && StickRobos_B[i].celly == newy) {
          givePerfume(StickRobos_B[i]);
        }
        if (StickRobos_R[i].cellx == newx && StickRobos_R[i].celly == newy) {
          givePerfume(StickRobos_R[i]);
        }
        if (FightBalls_B[i].cellx == newx && FightBalls_B[i].celly == newy) {
          givePerfume(FightBalls_B[i]);
        }
        if (FightBalls_R[i].cellx == newx && FightBalls_R[i].celly == newy) {
          givePerfume(FightBalls_R[i]);
        }
        if (FlowerLadys_B[i].cellx == newx && FlowerLadys_B[i].celly == newy) {
          givePerfume(FlowerLadys_B[i]);
        }
        if (FlowerLadys_R[i].cellx == newx && FlowerLadys_R[i].celly == newy) {
          givePerfume(FlowerLadys_R[i]);
        }
        if (Onions_B[i].cellx == newx && Onions_B[i].celly == newy) {
          givePerfume(Onions_B[i]);
        }
        if (Onions_R[i].cellx == newx && Onions_R[i].celly == newy) {
          givePerfume(Onions_R[i]);
        }
      }
    }
  }

  void givePerfume(Chara C) {
    Strengthened = C;
    Strengthened.atk += 2;
    special = false;
    attacking = false;
  }

  void BadBreath() {
    textFont(title);
    textAlign(CENTER);
    rectMode(CENTER);
    fill(255, 0, 0);
    text("Lift the character whose day you want to ruin", width/2, height/2, width/2, height/2);
    fill(0, 0, 0, 50);
    rect(width/2, height/2, width, height);
    keyboardCheck(); 
    if (contactMade && (newx != 0 && newy != 0) && abs(cellx-newx)+abs(celly-newy)<=range) {
      //check for each possible character to see if the x,y matches
      for (int i = 0; i < Defenders_B.length; i++) {
        if (Defenders_B[i].cellx == newx && Defenders_B[i].celly == newy) {
          weaken(Defenders_B[i]);
        }
        if (Defenders_R[i].cellx == newx && Defenders_R[i].celly == newy) {
          weaken(Defenders_R[i]);
        }
        if (Swampys_B[i].cellx == newx && Swampys_B[i].celly == newy) {
          weaken(Swampys_B[i]);
        }
        if (Swampys_R[i].cellx == newx && Swampys_R[i].celly == newy) {
          weaken(Swampys_R[i]);
        }
        if (StickRobos_B[i].cellx == newx && StickRobos_B[i].celly == newy) {
          weaken(StickRobos_B[i]);
        }
        if (StickRobos_R[i].cellx == newx && StickRobos_R[i].celly == newy) {
          weaken(StickRobos_R[i]);
        }
        if (FightBalls_B[i].cellx == newx && FightBalls_B[i].celly == newy) {
          weaken(FightBalls_B[i]);
        }
        if (FightBalls_R[i].cellx == newx && FightBalls_R[i].celly == newy) {
          weaken(FightBalls_R[i]);
        }
        if (FlowerLadys_B[i].cellx == newx && FlowerLadys_B[i].celly == newy) {
          weaken(FlowerLadys_B[i]);
        }
        if (FlowerLadys_R[i].cellx == newx && FlowerLadys_R[i].celly == newy) {
          weaken(FlowerLadys_R[i]);
        }
        if (Onions_B[i].cellx == newx && Onions_B[i].celly == newy) {
          weaken(Onions_B[i]);
        }
        if (Onions_R[i].cellx == newx && Onions_R[i].celly == newy) {
          weaken(Onions_R[i]);
        }
      }
    }
  }

  void weaken(Chara C) {
    Weakened = C;
    Weakened.atk -= 3;
    if (C.atk < 0) {
      Weakened.atk = 0;
    }
    extra = false;
  }
}

class Onion extends Chara {
  boolean OnionStarted = false;

  Onion(int Team, int Pos, int CellX, int CellY) {
    team = Team;
    position = Pos;
    cellx = CellX;
    celly = CellY;
    moving = false;
    moved = false;
    contactMade = false;
    attacking = false;
    special = false;
    hp = 3;
    hp_max = 3;
    atk = 1;
    move = 0;
    range = 1;
    newx = 0;
    newy = 0;
  }
  void MenuDisplay() {
    textFont(names);
    if (team == blue) {
      fill(0, 0, 255);
    }
    if (team == red) {
      fill(255, 0, 0);
    }
    rectMode(CORNER);
    displayLocation();
    text("El Cebollón " + position, 175, 100);
    pushMatrix();
    translate(200, height/2.2);
    showOnion(team);
    popMatrix();
    textFont(plain);
    fill(0);
    textAlign(LEFT);
    text("HP: " + hp, width-menuDisplaypos_txt, 150);
    text("ATTACK: " + atk, width-menuDisplaypos_txt, 200);
    text("MOVE: " + move, width-menuDisplaypos_txt, 250);
    textFont(specialExtra);
    text("SPECIAL: Dig", width-menuDisplaypos_txt, 300);
    text("EXTRA: Onion Vibes (always active)", width-menuDisplaypos_txt, 400, menuDisplaypos_txt, 100);
    textFont(descriptions);
    text("Move to an empty space (range: 2).", width-(menuDisplaypos_txt), 300, 300, 100);
    text("When attacked, deal 2 damage if attacker is adjacent.", width-(menuDisplaypos_txt), 450, 300, 200);
  }

  void hpDisplay() {
    float xpos = -50;
    pushMatrix();
    if (team == blue) {
      translate(hpDisplaypos*position, height-130);
    }
    if (team == red) {
      translate(hpDisplaypos*(position+3), height-130);
    }    
    mini_displayLocation();
    mini_protected();
    scale(0.2);
    if (hp > 0) {
      showOnion(team);
    }
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

  void OnionStart() {
    if (!OnionStarted) {
      if (cellx == 0 && celly == 0) {
        move = 1;
      } else {
        move = 0;
      }
      OnionStarted = true;
    }
  }

  void extraAction() {
    if (keyPressed) {
      if (key == 'c') {
        special = true;
      }
      if (!attacking && special) {
        Dig();
        attackStart = true;
      }
    }
    //ends turn
    if (!attacking && !special && !extra && attackStart) {
      turn++;
      attackStart = false;
    }
  }

  void Dig() {
    int oldx = cellx;
    int oldy = celly;
    move = 3;
    movement();
    if (oldx != cellx || oldy != celly) {
      special = false;
    }
    println(special);
  }
}

class StickRobo extends Chara {
  boolean RoboStarted = false;

  StickRobo(int Team, int Pos, int CellX, int CellY) {
    team = Team;
    position = Pos;
    cellx = CellX;
    celly = CellY;
    moving = false;
    moved = false;
    contactMade = false;
    attacking = false;
    special = false;
    hp = 1;
    hp_max = 1;
    atk = 2;
    move = 2;
    range = 2;
    newx = 0;
    newy = 0;
  }
  void MenuDisplay() {
    //println(range);
    textFont(names);
    if (team == blue) {
      fill(0, 0, 255);
    }
    if (team == red) {
      fill(255, 0, 0);
    }
    rectMode(CORNER);
    displayLocation();
    text("L1uv14 " + position, 200, 100);
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
    text("MOVE: " + move, width-menuDisplaypos_txt, 250);
    textFont(specialExtra);
    text("SPECIAL: Teleport", width-menuDisplaypos_txt, 300);
    text("EXTRA: Hug", width-menuDisplaypos_txt, 400);
    textFont(descriptions);
    text("Move anywhere on the board.", width-(menuDisplaypos_txt), 300, 300, 100);
    text("Deal 4 damage to 1 adjacent foe.", width-(menuDisplaypos_txt), 400, 300, 200);
  }

  void hpDisplay() {
    float xpos = -50;
    pushMatrix();
    if (team == blue) {
      translate(hpDisplaypos*position, height-130);
    }
    if (team == red) {
      translate(hpDisplaypos*(position+3), height-130);
    }
    mini_displayLocation();
    mini_protected();
    scale(0.2);
    if (hp > 0) {
      showStickRobo(team);
    }
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

  void RoboStart() {
    if (!RoboStarted) {
      range = 2;
      atk = 2;
      move = 3;
    }
  }

  void extraAction() {
    if (keyPressed) {
      if (key == 'c') {
        if (!moving) {
          special = true;
        } else if (moving && !usedExtra) {
          extra = true;
        }
      }
    }
    if (!attacking && !moving && special) {
      Teleport();
      attackStart = true;
    }
    if (!attacking && !special && !moving && extra) {
      Hug();
      attackStart = true;
    }
    //ends turn
    if (!attacking && !special && !extra && attackStart) {
      turn++;
      attackStart = false;
    }
  }

  void Hug() {
    atk = 4;
    range = 1;
    Attack();
  }

  void Teleport() {
    move = 6;
    boolean collided = false;
    //send signal to X+-m and Y+-m
    textFont(title);
    textAlign(CENTER);
    rectMode(CENTER);
    fill(255, 0, 0);
    text("Move your character on the board", width/2, height/2, width/2, height/2);
    fill(0, 0, 0, 50);
    rect(width/2, height/2, width, height);
    keyboardCheck();

    //prevents overlap
    for (int i = 0; i < Defenders_B.length; i++) {
      if (Defenders_B[i].cellx == newx && Defenders_B[i].celly == newy) {
        collided = true;
      }
      if (Defenders_R[i].cellx == newx && Defenders_R[i].celly == newy) {
        collided = true;
      }
      if (Swampys_B[i].cellx == newx && Swampys_B[i].celly == newy) {
        collided = true;
      }
      if (Swampys_R[i].cellx == newx && Swampys_R[i].celly == newy) {
        collided = true;
      }
      if (StickRobos_B[i].cellx == newx && StickRobos_B[i].celly == newy) {
        collided = true;
      }
      if (StickRobos_R[i].cellx == newx && StickRobos_R[i].celly == newy) {
        collided = true;
      }
      if (FightBalls_B[i].cellx == newx && FightBalls_B[i].celly == newy) {
        collided = true;
      }
      if (FightBalls_R[i].cellx == newx && FightBalls_R[i].celly == newy) {
        collided = true;
      }
      if (FlowerLadys_B[i].cellx == newx && FlowerLadys_B[i].celly == newy) {
        collided = true;
      }
      if (FlowerLadys_R[i].cellx == newx && FlowerLadys_R[i].celly == newy) {
        collided = true;
      }
      if (Onions_B[i].cellx == newx && Onions_B[i].celly == newy) {
        collided = true;
      }
      if (Onions_R[i].cellx == newx && Onions_R[i].celly == newy) {
        collided = true;
      }
    }
    if ((abs(cellx-newx)+abs(celly-newy))<=move && (newx != 0 && newy != 0) && contactMade && !collided) {
      cellx = newx;
      celly = newy;
      moving = false;
      moved = true;
      contactMade = false;
      special = false;
      newx = 0;
      newy = 0;
    }
  }
}

class Swampy extends Chara {

  Swampy(int Team, int Pos, int CellX, int CellY) {
    team = Team;
    position = Pos;
    cellx = CellX;
    celly = CellY;
    moving = false;
    moved = false;
    contactMade = false;
    attacking = false;
    special = false;
    hp = 2;
    hp_max = 2;
    atk = 3;
    move = 2;
    range = 1;
    newx = 0;
    newy = 0;
  }

  void MenuDisplay() {
    textFont(names);
    if (team == blue) {
      fill(0, 0, 255);
    }
    if (team == red) {
      fill(255, 0, 0);
    }
    rectMode(CORNER);
    displayLocation();
    text("María " + position, 200, 100);
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
    text("MOVE: " + move, width-menuDisplaypos_txt, 250);
    textFont(specialExtra);
    text("SPECIAL: Tail Slam", width-menuDisplaypos_txt, 300);
    text("EXTRA: Tail Twist", width-menuDisplaypos_txt, 400);
    textFont(descriptions);
    text("Does 2 damage and push target. Bumping causes both to take 1 damage.", width-(menuDisplaypos_txt), 300, 300, 100);
    text("Does 3 damage to all adjacent foes. Take 1 damage", width-(menuDisplaypos_txt), 400, 300, 200);
  }

  void hpDisplay() {
    float xpos = -50;
    pushMatrix();
    if (team == blue) {
      translate(hpDisplaypos*position, height-130);
    }
    if (team == red) {
      translate(hpDisplaypos*(position+3), height-130);
    }
    mini_displayLocation();
    mini_protected();
    scale(0.2);
    if (hp > 0) {
      showSwampy(team);
    }
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

  void extraAction() {
    if (keyPressed) {
      if (key == 'c') {
        if (!moving) {
          special = true;
        } else if (moving && !usedExtra) {
          extra = true;
        }
      }
    }
    if (!attacking && !moving && special) {
      TailSlam();
      attackStart = true;
    }
    if (!attacking && !special && !moving && extra) {
      TailTwist();
      attackStart = true;
    }
  }

  void TailSlam() {
    textFont(title);
    textAlign(CENTER);
    rectMode(CENTER);
    fill(255, 0, 0);
    text("Move the target one space back", width/2, height/2, width/2, height/2);
    fill(0, 0, 0, 50);
    rect(width/2, height/2, width, height);
    keyboardCheck(); 
    //check for each possible character to see if the x,y matches
    for (int i = 0; i < Defenders_B.length; i++) {
      if (Defenders_B[i].cellx == newx && Defenders_B[i].celly == newy) {
        push(Defenders_B[i]);
      }
      if (Defenders_R[i].cellx == newx && Defenders_R[i].celly == newy) {
        push(Defenders_R[i]);
      }
      if (Swampys_B[i].cellx == newx && Swampys_B[i].celly == newy) {
        push(Swampys_B[i]);
      }
      if (Swampys_R[i].cellx == newx && Swampys_R[i].celly == newy) {
        push(Swampys_R[i]);
      }
      if (StickRobos_B[i].cellx == newx && StickRobos_B[i].celly == newy) {
        push(StickRobos_B[i]);
      }
      if (StickRobos_R[i].cellx == newx && StickRobos_R[i].celly == newy) {
        push(StickRobos_R[i]);
      }
      if (FightBalls_B[i].cellx == newx && FightBalls_B[i].celly == newy) {
        push(FightBalls_B[i]);
      }
      if (FightBalls_R[i].cellx == newx && FightBalls_R[i].celly == newy) {
        push(FightBalls_R[i]);
      }
      if (FlowerLadys_B[i].cellx == newx && FlowerLadys_B[i].celly == newy) {
        push(FlowerLadys_B[i]);
      }
      if (FlowerLadys_R[i].cellx == newx && FlowerLadys_R[i].celly == newy) {
        push(FlowerLadys_R[i]);
      }
      if (Onions_B[i].cellx == newx && Onions_B[i].celly == newy) {
        push(Onions_B[i]);
      }
      if (Onions_R[i].cellx == newx && Onions_R[i].celly == newy) {
        push(Onions_R[i]);
      }
    }
  }

  void push(Chara C) { //moves the character and deals 1 damage if collided
    boolean collided = false;
    Chara victim = Dummy;
    //send signal to X+-m and Y+-m RGB LEDs

    C.hp -= 2;

    if (this.cellx == C.cellx+1) {
      newx = C.cellx-1;
      newy = celly;
    } else if (this.cellx == C.cellx-1) {
      newx = C.cellx+1;
      newy = celly;
    } else if (this.celly == C.celly+1) {
      newy = C.celly-1;
      newx = cellx;
    } else if (this.celly == C.celly-1) {
      newy = C.celly+1;
      newx = cellx;
    }

    //prevents overlap
    for (int i = 0; i < Defenders_B.length; i++) {
      if (Defenders_B[i].cellx == newx && Defenders_B[i].celly == newy) {
        collided = true;
        victim = Defenders_B[i];
      }
      if (Defenders_R[i].cellx == newx && Defenders_R[i].celly == newy) {
        collided = true;
        victim = Defenders_R[i];
      }
      if (Swampys_B[i].cellx == newx && Swampys_B[i].celly == newy) {
        collided = true;
        victim = Swampys_B[i];
      }
      if (Swampys_R[i].cellx == newx && Swampys_R[i].celly == newy) {
        collided = true;
        victim = Swampys_R[i];
      }
      if (StickRobos_B[i].cellx == newx && StickRobos_B[i].celly == newy) {
        collided = true;
        victim = StickRobos_B[i];
      }
      if (StickRobos_R[i].cellx == newx && StickRobos_R[i].celly == newy) {
        collided = true;
        victim = StickRobos_R[i];
      }
      if (FightBalls_B[i].cellx == newx && FightBalls_B[i].celly == newy) {
        collided = true;
        victim = FightBalls_B[i];
      }
      if (FightBalls_R[i].cellx == newx && FightBalls_R[i].celly == newy) {
        collided = true;
        victim = FightBalls_R[i];
      }
      if (FlowerLadys_B[i].cellx == newx && FlowerLadys_B[i].celly == newy) {
        collided = true;
        victim = FlowerLadys_B[i];
      }
      if (FlowerLadys_R[i].cellx == newx && FlowerLadys_R[i].celly == newy) {
        collided = true;
        victim = FlowerLadys_R[i];
      }
      if (Onions_B[i].cellx == newx && Onions_B[i].celly == newy) {
        collided = true;
        victim = Onions_B[i];
      }
      if (Onions_R[i].cellx == newx && Onions_R[i].celly == newy) {
        collided = true;
        victim = Onions_R[i];
      }
    }

    if ((abs(cellx-newx)+abs(celly-newy))<=move && (newx != 0 && newy != 0) && contactMade && !collided) {
      C.cellx = newx;
      C.celly = newy;
      moving = false;
      moved = true;
      contactMade = false;
      newx = 0;
      newy = 0;
      special = false;
    } else if (newx == 0 || newx == 5 || newy == 0 || newy == 5) {
      moving = false;
      moved = true;
      contactMade = false;
      newx = 0;
      newy = 0;
      special = false;
    } else if (collided) {
      C.hp--;
      victim.hp--;
      moving = false;
      moved = true;
      contactMade = false;
      newx = 0;
      newy = 0;
      special = false;
    }
  }

  void TailTwist() {
    //checks if any other characters are adjacent
    for (int n = 0; n < 4; n++) {
      if (n==0) {
        newx = cellx-1;
        newy = celly;
      }
      if (n==1) {
        newx = cellx+1;
        newy = celly;
      }
      if (n==2) {
        newx = cellx;
        newy = celly-1;
      }
      if (n==3) {
        newx = cellx;
        newy = celly+1;
      }
      for (int i = 0; i < Defenders_B.length; i++) {
        if (Defenders_B[i].cellx == newx && Defenders_B[i].celly == newy) {
          takeDamage(Defenders_B[i]);
        }
        if (Defenders_R[i].cellx == newx && Defenders_R[i].celly == newy) {
          takeDamage(Defenders_R[i]);
        }
        if (Swampys_B[i].cellx == newx && Swampys_B[i].celly == newy) {
          takeDamage(Swampys_B[i]);
        }
        if (Swampys_R[i].cellx == newx && Swampys_R[i].celly == newy) {
          takeDamage(Swampys_R[i]);
        }
        if (StickRobos_B[i].cellx == newx && StickRobos_B[i].celly == newy) {
          takeDamage(StickRobos_B[i]);
        }
        if (StickRobos_R[i].cellx == newx && StickRobos_R[i].celly == newy) {
          takeDamage(StickRobos_R[i]);
        }
        if (FightBalls_B[i].cellx == newx && FightBalls_B[i].celly == newy) {
          takeDamage(FightBalls_B[i]);
        }
        if (FightBalls_R[i].cellx == newx && FightBalls_R[i].celly == newy) {
          takeDamage(FightBalls_R[i]);
        }
        if (FlowerLadys_B[i].cellx == newx && FlowerLadys_B[i].celly == newy) {
          takeDamage(FlowerLadys_B[i]);
        }
        if (FlowerLadys_R[i].cellx == newx && FlowerLadys_R[i].celly == newy) {
          takeDamage(FlowerLadys_R[i]);
        }
        if (Onions_B[i].cellx == newx && Onions_B[i].celly == newy) {
          takeDamage(Onions_B[i]);
          if (this.range == 1) {
            this.hp -= 2;
          }
        }
        if (Onions_R[i].cellx == newx && Onions_R[i].celly == newy) {
          takeDamage(Onions_R[i]);
          if (this.range == 1) {
            this.hp -= 2;
          }
        }
      }
    }
    hp--; //deals damage to itself
  }
}
