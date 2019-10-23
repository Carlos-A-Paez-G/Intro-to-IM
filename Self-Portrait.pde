int t = 0;
beardHair beard[] = new beardHair[300]; 



void setup() {
  size(300, 300);
  frameRate(3);
}

void draw() {
  background(245, 195, 137); 
  strokeWeight(2);
  stroke(0);

  //eyes
  fill(255);
  ellipse(width/4, 75, width/4, 75/2);
  ellipse(width/4*3, 75, width/4, 75/2);

  //pupils
  fill(0);
  arc(width/4, 70, width/8, width/8, 0, PI, PIE);
  arc(width/4*3, 70, width/8, width/8, 0, PI, PIE);

  //eyelids
  fill(245, 195, 137);
  pushMatrix();
  translate(300/4, 75);
  rotate(PI);
  arc(0, 0, width/4, 75/2, 0, PI);
  arc(-width/2, 0, width/4, 75/2, 0, PI);
  popMatrix();

  //nose
  fill(0);
  ellipse(width*3/8 + 25, 150, 15, 5);
  ellipse(width*3/8 + 25 + 35, 150, 15, 5);

  //eyebrows
  fill(0);
  quad(width/7, 50, width/9, 45, width/5, 40, width/2-20, 55);
  pushMatrix();
  translate(width/4*2, 0);
  quad(width/2-width/7, 50, width/2-width/9, 45, width/2-width/5, 40, 25, 55);
  popMatrix();

  //mouth
  strokeWeight(10);
  noFill();
  stroke(235, 103, 91);
  pushMatrix();
  translate(width/2, 200);
  curve(5-width/2, 293-200, -50, 30, 50, 30, 50, 30);
  popMatrix();

  //beard - it grows and then gets shaven, which is what I always do with it instead of keeping it at a constant length
  for (int n = 0; n < 100; n++) {
    beard[n] = new beardHair();
    beard[n].exist();
  }
  t++;
  if (t >= 20) {
    t = 0;
  }
}

//code used to find coordinates
void mouseClicked() {
  translate(width/2, 200);
  println("X =" + mouseX);
  println("Y =" + mouseY);
}
