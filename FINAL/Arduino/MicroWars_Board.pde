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

//Buttons Pins
const int RED_1 = 41;
const int GREEN_1 = 42;
const int BLUE_1 = 43;
const int RED_2 = 44;
const int GREEN_2 = 45;
const int BLUE_2 = 46;

//int t = 0;
//const int bufferTime = 10000;

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

//For measuring change in LDR reading
int LDRthreshold = 250;
float prev_a1 = 0;
float prev_a2 = 0;
float prev_a3 = 0;
float prev_a4 = 0;

void setup() {
  Serial.begin(9600);
  for (int i = 2; i <= 40; i++) {
    pinMode(OUTPUT, i);
  }
  for (int i = 41; i <= 46; i++) {
    pinMode(INPUT, i);
  }
  //  while (!Serial) {
  //    ; // wait for serial port to connect. Needed for native USB port only
  //  }
  //  establishContact();
}

void loop() {
  //if (Serial.available() > 0) {

  buttonCheck();
  //}

  //**LDR'S**
  float v_a1 = analogRead(A0);
  if (abs(v_a1 - prev_a1) > LDRthreshold) {
    Serial.println("A - 1");
    prev_a1 = v_a1;
  }
  float v_a2 = analogRead(A1);
  if (abs(v_a2 - prev_a2) > LDRthreshold) {
    Serial.println("A - 2");
    prev_a2 = v_a2;
  }
  float v_a3 = analogRead(A2);
  if (abs(v_a3 - prev_a3) > LDRthreshold) {
    Serial.println("A - 3");
    prev_a3 = v_a3;
  }
  float v_a4 = analogRead(A3);
 // Serial.println(v_a4);
  if (abs(v_a4 - prev_a4) > LDRthreshold) {
    Serial.println("A - 4");
    prev_a4 = v_a4;
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
  //Serial.println("waiting");
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

void establishContact() {
  while (Serial.available() <= 0) {
    Serial.print('A');   // send a capital A
    delay(300);
  }
}
