int pos = 29; //size of the squares
int layer = 17; 
int t = layer/2;

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
  noFill();
  strokeWeight(3);
  rectMode(CENTER);
  
  //draws border
  pushMatrix();
  translate(width/2, height/2);
  rect(0, 0, width-20, height-20);
  popMatrix();
  
  //set starting position
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
  rect(0, 0, pos, pos);
}

void draw(){
}

void drawLines() { //draws lines inside square in a random order
  while (t > 0) {
    int d = int(random(1, 9));
    println(d);
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
