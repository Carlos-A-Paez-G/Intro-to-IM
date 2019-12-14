/* BOARD DIAGRAM  (the capital letter locations is where the LEDs would have been)
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

//------ADD THE PREV CONSTANTS FOR b thru d-------


//Buttons Pins
const int RED_1 = 39;
const int GREEN_1 = 28;
const int BLUE_1 = 26;
const int RED_2 = 33;
const int GREEN_2 = 38;
const int BLUE_2 = 36;

//LDR pins
const int a1 = A0;
const int a2 = A1;
const int a3 = A2;
const int a4 = A3;
const int b1 = A5;
const int b2 = A4;
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

//For measuring change in LDR reading
int LDRthreshold = 300; //Whenever there is a change beyond this value in an LDR, send a message to Processing of which LDR was changed
float prev_a1 = 0;
float prev_a2 = 0;
float prev_a3 = 0;
float prev_a4 = 0;
float prev_b1 = 0;
float prev_b2 = 0;
float prev_b3 = 0;
float prev_b4 = 0;
float prev_c1 = 0;
float prev_c2 = 0;
float prev_c3 = 0;
float prev_c4 = 0;
float prev_d1 = 0;
float prev_d2 = 0;
float prev_d3 = 0;
float prev_d4 = 0;

void setup() {
  Serial.begin(9600);
  pinMode(INPUT, RED_1);
  pinMode(INPUT, RED_2);
  pinMode(INPUT, GREEN_1);
  pinMode(INPUT, GREEN_2);
  pinMode(INPUT, BLUE_1);
  pinMode(INPUT, BLUE_2);
}

void loop() {
  buttonCheck();

  //**LDR'S**
  float v_a1 = analogRead(a1);
  //Serial.println(v_a1);
  if (abs(v_a1 - prev_a1) > LDRthreshold) {
    Serial.println("A - 1");
    prev_a1 = v_a1;
  }
  float v_a2 = analogRead(a2);
  if (abs(v_a2 - prev_a2) > LDRthreshold) {
    Serial.println("A - 2");
    prev_a2 = v_a2;
  }
  float v_a3 = analogRead(a3);
  if (abs(v_a3 - prev_a3) > LDRthreshold) {
    Serial.println("A - 3");
    prev_a3 = v_a3;
  }
  float v_a4 = analogRead(a4);
  // Serial.println(v_a4);
  if (abs(v_a4 - prev_a4) > LDRthreshold) {
    Serial.println("A - 4");
    prev_a4 = v_a4;
  }
  float v_b1 = analogRead(b1);
  if (abs(v_b1 - prev_b1) > LDRthreshold) {
    Serial.println("B - 1");
    prev_b1 = v_b1;
  }
  float v_b2 = analogRead(b2);
  if (abs(v_b2 - prev_b2) > LDRthreshold) {
    Serial.println("B - 2");
    prev_b2 = v_b2;
  }
  float v_b3 = analogRead(b3);
  if (abs(v_b3 - prev_b3) > LDRthreshold) {
    Serial.println("B - 3");
    prev_b3 = v_b3;
  }
  float v_b4 = analogRead(b4); //***SOLDERING PROBLEM*** ---> FIXED!
   //Serial.println(v_b4);
  if (abs(v_b4 - prev_b4) > LDRthreshold) {
    Serial.println("B - 4");
    prev_b4 = v_b4;
  }

  float v_c1 = analogRead(c1);
  if (abs(v_c1 - prev_c1) > LDRthreshold) {
    Serial.println("C - 1");
    prev_c1 = v_c1;
  }
  float v_c2 = analogRead(c2);
  if (abs(v_c2 - prev_c2) > LDRthreshold) {
    Serial.println("C - 2");
    prev_c2 = v_c2;
  }
  float v_c3 = analogRead(c3); //***SOLDERING PROBLEM*** ---> FIXED!
     //Serial.println(v_c3);
  if (abs(v_c3 - prev_c3) > LDRthreshold) {
    Serial.println("C - 3");
    prev_c3 = v_c3;
  }
  float v_c4 = analogRead(c4);
   //Serial.println(v_c4); //***SOLDERING PROBLEM*** ---> FIXED!
  if (abs(v_c4 - prev_c4) > LDRthreshold) {
    Serial.println("C - 4");
    prev_c4 = v_c4;
  }

  float v_d1 = analogRead(d1);
  if (abs(v_d1 - prev_d1) > LDRthreshold) {
    Serial.println("D - 1");
    prev_d1 = v_d1;
  }
  float v_d2 = analogRead(d2);
  if (abs(v_d2 - prev_d2) > LDRthreshold) {
    Serial.println("D - 2");
    prev_d2 = v_d2;
  }
  //Serial.println(d2);
  float v_d3 = analogRead(d3);
  if (abs(v_d3 - prev_d3) > LDRthreshold) {
    Serial.println("D - 3");
    prev_d3 = v_d3;
  }
  float v_d4 = analogRead(d4);
  // Serial.println(v_a4);
  if (abs(v_d4 - prev_d4) > LDRthreshold) {
    Serial.println("D - 4");
    prev_d4 = v_d4;
  }

}

void buttonCheck() {
  //**Checking buttons**
  if (digitalRead(RED_1) == 1) {
    Serial.println("R1");
  }
  if (digitalRead(GREEN_1) == 1) {
    Serial.println("G1");
  }
  if (digitalRead(BLUE_1) == HIGH) {
    Serial.println("B1");
  }
  if (digitalRead(RED_2) == 1) {
    Serial.println("R2");
  }
  if (digitalRead(GREEN_2) == 1) {
    Serial.println("G2");
  }
  if (digitalRead(BLUE_2) == 1) {
    Serial.println("B2");
  }
}
