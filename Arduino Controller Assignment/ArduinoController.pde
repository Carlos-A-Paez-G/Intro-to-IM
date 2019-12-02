const int RED_PIN = 4;
const int BLUE_PIN = 5;
const int GREEN_PIN = 6;
const int YELLOW_PIN = 7;

void setup() {
  Serial.begin(9600);
  pinMode(GREEN_PIN, INPUT);
  pinMode(RED_PIN, INPUT);
  pinMode(BLUE_PIN, INPUT);
  pinMode(YELLOW_PIN, INPUT);
}

void loop() {
  int Red = digitalRead(4);
  int Blue = digitalRead(5);
  int Green = digitalRead(6);
  int Yellow = digitalRead(7);

  if (Red == 1) {
    Serial.println("RED");
  }

  if (Blue == 1) {
    Serial.println("BLUE");
  }
  
  if (Green == 1) {
    Serial.println("GREEN");
  }

  if (Yellow == 1) {
    Serial.println("YELLOW");
  }
}


