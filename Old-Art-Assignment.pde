size(1000, 1000);
ellipseMode(RADIUS);
noFill();
translate(50, 50);
float[] pies = {0, HALF_PI, PI, PI+HALF_PI, TWO_PI};
int start = int(random(pies.length));
int end = int(random(pies.length));
while (start > end) {
  println("start = " + start + " end = " + end);
  start = int(random(pies.length));
  end = int(random(pies.length));
}
arc(50, 50, 50, 50, pies[start], pies[end]);

