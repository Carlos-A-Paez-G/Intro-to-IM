/* BOARD DIAGRAM
    A1--  --A3--  --A5
    | a1 | a2 | a3| a4|
      --B2--  --B4--
    | b1 | b2 | b3| b4|
    C1--  --C3--  --C5
    | c1 | c2 | c3| c4|
      --D2--  --D4--
    | d1 | d2| d3| d4|
    E1--  --E3--  --E5
*/

//RGB LED pins
const int A1_R = 2;
const int A1_G = 3;
const int A1_B = 4;
const int A3_R = 5;
const int A3_G = 6;
const int A3_B = 7;
const int A5_R = 8;
const int A5_G = 9;
const int A5_B = 10;
const int B2_R = 11;
const int B2_G = 12;
const int B2_B = 13;
const int B4_R = 14;
const int B4_G = 15;
const int B4_B = 16;
const int C1_R = 17;
const int C1_G = 18;
const int C1_B = 19;
const int C3_R = 20;
const int C3_G = 21;
const int C3_B = 22;
const int C5_R = 23;
const int C5_G = 24;
const int C5_B = 25;
const int D2_R = 26;
const int D2_G = 27;
const int D2_B = 28;
const int D4_R = 29;
const int D4_G = 30;
const int D4_B = 31;
const int E1_R = 32;
const int E1_G = 33;
const int E1_B = 34;
const int E3_R = 35;
const int E3_G = 36;
const int E3_B = 37;
const int E5_R = 38;
const int E5_G = 39;
const int E5_B = 40;

//Buttons Pins
const int RED_1 = 41;
const int GREEN_1 = 42;
const int BLUE_1 = 43;
const int RED_2 = 44;
const int GREEN_2 = 45;
const int BLUE_2 = 46;

//LDR pins
const int a1 = A0;
const int a2 = A1;
const int a3 = A2;
const int a4 = A3;
const int b1 = A4;
const int b2 = A5;
const int b3 = A6;
const int b4 = A7;
const int c1 = A8;
const int c2 = A9;
const int c3 = A10;
const int c4 = A11;
const int d1 = A12;
const int d2 = A13;
const int d3 = A14;
const int d4 = A15;





void setup() {
  for (int i = 2; i <= 46; i++) {
    pinMode(OUTPUT, i);
  }
  Serial.begin(9600);
}

void loop() {
  //**READ LDRs**
  float v - a1 = analogRead(a1);
  //  Serial.print(v-a1);
  float v - a2 = analogRead(a2);
  //  Serial.print(v-a2);
  float v - a3 = analogRead(a3);
  //  Serial.print(v-a3);
  float v - a4 = analogRead(a4);
  //  Serial.print(v-a4);
  float v - b1 = analogRead(b1);
  //  Serial.print(v-b1);
  float v - b2 = analogRead(b2);
  //  Serial.print(v-b2);
  float v - b3 = analogRead(b3);
  //  Serial.print(v - b3);
  float v - b4 = analogRead(b4);
  //  Serial.print(v - b4);
  float v - c1 = analogRead(c1);
  //  Serial.print(v - c1);
  float v - c2 = analogRead(c2);
  //  Serial.print(v - c2);
  float v - c3 = analogRead(c3);
  //  Serial.print(v - c3);
  float v - c4 = analogRead(c4);
  //  Serial.print(v - c4);
  float v - d1 = analogRead(d1);
  //  Serial.print(v - d1);
  float v - d2 = analogRead(d2);
  //  Serial.print(v - d2);
  float v - d3 = analogRead(d3);
  //  Serial.print(v - d3);
  float v - d4 = analogRead(d4);
  //  Serial.print(v - d4);

  //**READ BUTTONS**
  if (digitalRead(RED_1) == 1) {
    //do some serialWrite thingy
  }
  if (digitalRead(GREEN_1) == 1) {
    //do some serialWrite thingy
  }
  if (digitalRead(BLUE_1) == 1) {
    //do some serialWrite thingy
  }
  if (digitalRead(RED_2) == 1) {
    //do some serialWrite thingy
  }
  if (digitalRead(GREEN_2) == 1) {
    //do some serialWrite thingy
  }
  if (digitalRead(BLUE_2) == 1) {
    //do some serialWrite thingy
  }

  //**LIGHT UP RGB LEDs -- RED COLOR**
  
  digitalWrite(
  
}
