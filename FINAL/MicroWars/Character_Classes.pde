//**CHARACTER CLASSES**
//class Chara {
//  int hp;
//  int atk = 1;
//  int move = 1;
//  int team;
//  int id;

//  Chara(int Team, int ID) {
//    team = Team;
//    id = ID;
//  }

//  if (id == 0) {
//    hp = 5;
//    atk = 1;
//    move = 1;
//  }
//}
class Defender {
  int hp = 5;
  int atk = 1;
  int move = 1;
  int team;
  int position;

  Defender(int Team, int Pos) {
    team = Team;
    position = Pos;
  }

  void MenuDisplay() {
    textFont(names);
    if (team == blue) {
      fill(0, 0, 255);
    }
    if (team == red) {
      fill(255, 0, 0);
    }
    text("Defender", 200, 100);
    pushMatrix();
    translate(300, height/2);
    showDefender(team);
    popMatrix();
    textFont(plain);
    fill(0);
    text("HP: " + hp, width-150, 150);
    text("ATTACK: " + atk, width-150, 200);
    text("MOVE: " + hp, width-150, 250);
    text("SPECIAL: Shield", width-150, 300);
  }
  
  void hpDisplay(){
   pushMatrix();
    translate(150, height-100);
    scale(0.2);
    showFlowerLady(blue);
    popMatrix(); 
  }
}

class Swampy {
  int hp = 2;
  int atk = 3;
  int move = 2;
  int team;

  Swampy(int Team) {
    team = Team;
  }
}

class StickRobo {
  int hp = 1;
  int atk = 2; //range is 2
  int move = 3;
  int team;

  StickRobo(int Team) {
    team = Team;
  }
}

class FightBall {
  int hp = 4;
  int atk = 2;
  int move = 2;
  int team;

  FightBall(int Team) {
    team = Team;
  }
}

class FlowerLady {
  int hp = 5;
  int atk = 0;
  int move = 1;
  int team;

  FlowerLady(int Team) {
    team = Team;
  }
}

class Onion {
  int hp = 5;
  int atk = 0;
  int move = 1;
  int team;

  Onion(int Team) {
    team = Team;
  }
}
