//Functions for displaying Character Sprites
void showDefender(int Team) {
  if (Team != 0 && Team != 1) {
    println("show function only takes 0 or 1");
    exit();
  }
  pushMatrix();
  if(Team == red){
   scale(-1,1); 
  }
  scale(0.5);  
  image(charaPictures[2+Team], 0, 0);
  popMatrix();
}

void showDefender_noShield(int Team) {
  if (Team != 0 && Team != 1) {
    println("show function only takes 0 or 1");
    exit();
  }
  pushMatrix();
  if(Team == red){
   scale(-1,1); 
  }
  scale(0.5);  
  image(charaPictures[0+Team], 0, 0);
  popMatrix();
}

void showSwampy(int Team){
  if (Team != 0 && Team != 1) {
    println("show function only takes 0 or 1");
    exit();
  }
  pushMatrix();
  if(Team == red){
   scale(-1,1); 
  }
  scale(0.5);  
  image(charaPictures[4+Team], 0, 0);
  popMatrix();
}

void showStickRobo(int Team){
  if (Team != 0 && Team != 1) {
    println("show function only takes 0 or 1");
    exit();
  }
  pushMatrix();
  if(Team == red){
   scale(-1,1); 
  }
  scale(0.4);  
  image(charaPictures[6+Team], 0, 0);
  popMatrix();
}

void showFightBall(int Team){
  if (Team != 0 && Team != 1) {
    println("show function only takes 0 or 1");
    exit();
  }
  pushMatrix();
  if(Team == red){
   scale(-1,1); 
  }
  scale(0.5);  
  image(charaPictures[8+Team], 0, 0);
  popMatrix();
}

void showFlowerLady(int Team){
  if (Team != 0 && Team != 1) {
    println("show function only takes 0 or 1");
    exit();
  }
  pushMatrix();
  if(Team == red){
   scale(-1,1); 
  }
  scale(0.4);  
  image(charaPictures[10+Team], 0, 0);
  popMatrix();
}

void showOnion(int Team){
  if (Team != 0 && Team != 1) {
    println("show function only takes 0 or 1");
    exit();
  }
  pushMatrix();
  if(Team == red){
   scale(-1,1); 
  }
  scale(0.4);  
  image(charaPictures[12+Team], 0, 0);
  popMatrix();
}
