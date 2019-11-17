import processing.serial.*;

//for communication
Serial receiver;
String buttonInput;

int pos = 29; //size of the squares
int layer = 17; 
int t = layer/2;

color c[] = new color[4];

boolean execute = false;
boolean mouse = false; //checks if mouse has been pressed within the last frame

boolean red = false;
boolean blue = false;
boolean yellow = false;
boolean green = false;

int chooseCount = 0;

int l1 = 0;
int l2 = 0;
int l3 = 0;
int l4 = 0;
int l5 = 0;
int l6 = 0;
int l7 = 0;
int l8 = 0;

void setup() {
  size(798, 798);

  strokeWeight(3);
  rectMode(CENTER);

  for (int i = 0; i < c.length; i++) {
    c[i] = 0;
  }
  
  //initializes input port
  println(Serial.list());
  String portName = Serial.list()[0];
  receiver = new Serial(this, portName, 9600);
  receiver.clear();
  receiver.bufferUntil('\n');
}

void draw() {
  //makes lines be drawn only on command
  if (mouse) {
    execute = false;
  }
  if (mousePressed && !mouse) {
    execute = true; 
    mouse = true;
  } 
  if (!mousePressed) {
    mouse = false; 
    execute = false;
  }

  chooseColors();
 // chooseColorsDebug();

  if (execute) {
    background(200);
    noFill();
    //draws border
    stroke(0);
    pushMatrix();
    translate(width/2, height/2);
    rect(0, 0, width-20, height-20);
    popMatrix();

    //set starting position
    pushMatrix();
    translate(1.5*pos, 1.5*pos);

    while (layer > 1) {
      for (int i = 1; i < layer; i++) { //this loop draws a line of squares rightwards
        rect(0, 0, pos, pos);
        drawLines();
        translate(1.5*pos, 0);
        linesReset();
      }
      for (int i = 1; i < layer; i++) { //this loop draws a line of squares downwards
        rect(0, 0, pos, pos);
        drawLines();
        translate(0, 1.5*pos);
        linesReset();
      }
      for (int i = 1; i < layer; i++) { //this loop draws a line of squares leftwards
        rect(0, 0, pos, pos);
        drawLines();
        translate(-1.5*pos, 0);
        linesReset();
      }

      for (int i = 1; i < layer; i++) { //this loop draws a line of squares upwards
        rect(0, 0, pos, pos);
        drawLines();
        translate(0, -1.5*pos);
        linesReset();
      }
      layer-=2;
      t = layer/2;
      translate(1.5*pos, 1.5*pos);
    }
    rect(0, 0, pos, pos); //draws last rectangle 
    popMatrix();
    processReset();
  }
}




//draws onelines inside square in a random order. The amount drawn depends on which layer it is on
void drawLines() { 
  while (t > 0) {
    int d = int(random(1, 9)); //chooses which line will get drawn this time around the loop
    color C = c[int(random(0, c.length))];
    stroke(C);
    //println(d);
    if (d == 1 && l1 == 0) {
      line(-pos/2, -pos/2, pos/2, pos/2);
      l1++;
      t--;
    }

    if (d == 2 && l2 == 0) {
      line(0, -pos/2, 0, pos/2);
      l2++;
      t--;
    }

    if (d == 3 && l3 == 0) {
      line(pos/2, -pos/2, -pos/2, pos/2);
      l3++;
      t--;
    }

    if (d == 4 && l4 == 0) {
      line(-pos/2, 0, pos/2, 0);
      l4++;
      t--;
    }

    if (d == 5 && l5 == 0) {
      line(-pos/2, 0, 0, -pos/2);
      l5++;
      t--;
    }

    if (d == 6 && l6 == 0) {
      line(pos/2, 0, 0, pos/2);
      l6++;
      t--;
    }

    if (d == 7 && l7 == 0) {
      line(0, pos/2, -pos/2, 0);
      l7++;
      t--;
    } 

    if (d == 8 && l8 == 0) {
      line(0, -pos/2, pos/2, 0);
      l8++;
      t--;
    }
  }
}

//resets the lines process (remnant from first last assignment)
void linesReset() {
  l1 = 0;
  l2 = 0;
  l3 = 0;
  l4 = 0;
  l5 = 0;
  l6 = 0;
  l7 = 0;
  l8 = 0;
  t = layer/2;
}

//resets everything
void processReset() {
  layer = 17;
  linesReset();
  red = false;
  blue = false;
  green = false;
  yellow = false;
  chooseCount = 0;
  for (int i = 0; i < c.length; i++) {
    c[i] = 0;
  }
}

void serialEvent(){
       buttonInput = receiver.readStringUntil('\n'); 

   if(buttonInput != null){
    buttonInput = trim(buttonInput); 
   }
}

//This will read which button has been pressed on the Arduino, and make it so that the sketch is colored accordingly afterwards
void chooseColors() {
  println(buttonInput);
    if (buttonInput == "RED" && !red) {
      c[chooseCount] = color(255, 0, 0);
      red = true;
      chooseCount++;
      println("HI");
    }
    if (buttonInput == "BLUE" && !blue) {
      c[chooseCount] = color(0, 0, 255);
      blue = true;
      chooseCount++;
    }
    if (buttonInput == "GREEN" && !green) {
      c[chooseCount] = color(0, 255, 0);
      green = true;
      chooseCount++;

    }
    if (buttonInput == "YELLOW" && !yellow) {
      c[chooseCount] = color(250, 246, 27);
      yellow = true;
      chooseCount++;
    }
  drawChosen();
}

//lets you change colors with the laptop's keyboard
//void chooseColorsDebug() {
//  if (keyPressed) {
//    if (key == 'q' && !red) {
//      c[chooseCount] = color(255, 0, 0);
//      red = true;
//      chooseCount++;
//    }
//    if (key == 'w' && !blue) {
//      c[chooseCount] = color(0, 0, 255);
//      blue = true;
//      chooseCount++;
//    }
//    if (key == 'e' && !green) {
//      c[chooseCount] = color(0, 255, 0);
//      green = true;
//      chooseCount++;
//    }
//    if (key == 'r' && !yellow) {
//      c[chooseCount] = color(250, 246, 27);
//      yellow = true;
//      chooseCount++;
//    }
//  }

//  drawChosen();
//}

void drawChosen() {
  noStroke();
  if (chooseCount > 0) {
    fill(c[0]);
    ellipse(width-100, height-20, 8, 8);
  }
  if (chooseCount > 1) {
    fill(c[1]);
    ellipse(width-80, height-20, 8, 8);
  }
  if (chooseCount > 2) {
    fill(c[2]);
    ellipse(width-60, height-20, 8, 8);
  }
  if (chooseCount > 3) {
    fill(c[3]);
    ellipse(width-40, height-20, 8, 8);
  }
}
