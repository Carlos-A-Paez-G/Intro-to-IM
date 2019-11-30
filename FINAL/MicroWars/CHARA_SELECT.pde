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
