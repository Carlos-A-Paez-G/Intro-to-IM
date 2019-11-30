int TITLE = 0;
int TESTING = 100;
int gameState = TESTING;
int CHARA_SELECT = 1;

int blue = 0;
int red = 1;

Defender Defender_B = new Defender(blue, 1);

//Fonts
PFont title;
PFont names;
PFont descriptions;
PFont plain;

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
      if(SELECT_tText == 100){
       SELECT_showText *= -1;
       SELECT_tText = 0;
      }
    }
  }
  //*********USE TO TEST THINGS************
  if(gameState == TESTING){
    Defender_B.MenuDisplay();
    
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
