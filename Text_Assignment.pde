//Move your mouse over the dark haze of creativity to find the words
//Click on them to let them fall onto the page of your poem


PFont f;
float size = 32;
String nouns[] = {"PERSON", "PANCAKE", "BALLOON", "CROCODILE", "CLOUD", "CARBOHYDRATE", "MILK", "INSTITUTION", "PARTY", "SQUID", "BIT", "WATER", "PAINTER", "DAUGHTER", "FRANKNESS", "LABURNUM", "ABROAD"};
String verbs[] = {"RECOGNIZES", "DREAMS", "SQUEEZES", "DISAGREES", "CURES", "PROTECTS", "ARRESTS", "LAUNCHES", "FLOWS", "DANCES", "GLOWS", "FUSES", "INHALE", "HALT"};
String adjectives[] = {"BIG", "CALM", "HOT", "WAVY", "SMOOTH", "STUPID", "COMPLICATED", "CLOSED MINDED", "FLAT", "LIVELY", "ADVENTUROUS", "COLORFUL", "LOADED", "CLEG-TORMENTED", "HAINOUS"};
String adverbs[] = {"HUNGRILY", "GLEEFULLY", "STEALTHILY", "ROUGHLY", "SEDUCTIVELY", "ODDLY", "TOMORROW", "VERY SOON", "LAZILY", "LITERALLY", "LIKE PLASTIC", "RESENTFULLY"};

int wordAmount = 10;

float poemPlace = 100;

Word Nouns[] = new Word[wordAmount];
Word Verbs[] = new Word[wordAmount];
Word Adjectives[] = new Word[wordAmount];
Word Adverbs[] = new Word[wordAmount];

void setup() {
  size(850, 800); 
  f = createFont("Courier", size);
  textFont(f, size);


  //initialize arrays of Words class
  for (int i = 0; i < Adjectives.length; i++) {
    Adjectives[i] = new Word(new PVector(100, 100*i), adjectives[int(random(0, adjectives.length-1))], radians(random(10, 50)));
  }

  for (int i = 0; i < Nouns.length; i++) {
    Nouns[i] = new Word(new PVector(200, 100*(i+1)), nouns[int(random(0, nouns.length-1))], radians(random(10, 50)));
  }

  for (int i = 0; i < Verbs.length; i++) {
    Verbs[i] = new Word(new PVector(300, 100*(i+1)), verbs[int(random(0, verbs.length-1))], radians(random(10, 50)));
  }

  for (int i = 0; i < Adverbs.length; i++) {
    Adverbs[i] = new Word(new PVector(400, 100*(i+1)), adverbs[int(random(0, adverbs.length-1))], radians(random(10, 50)));
  }
}

void draw() {
  background(255);
  
  //draw background for poem
  fill(247, 229, 176);
  noStroke();
  rect(520,0,width,height);
  
  //draw background for where the words are
  fill(15);
  rect(0,0,520,height);

  //checks for each word in the arrays and makes the corresponding functions happen
  for (int i = 0; i < wordAmount; i++) {

    //checking for adjectives
    if (!Adjectives[i].falling) {
      Adjectives[i].checkReset();
      Adjectives[i].choose();
      Adjectives[i].lifting();
      if (Adjectives[i].chosen && mousePressed) {
        Adjectives[i].makeFall();
      }
    }
    if (Adjectives[i].falling) {
      Adjectives[i].fall();
      Adjectives[i].checkPoem();
    }


    //checking for nouns
    if (!Nouns[i].falling) {
      Nouns[i].checkReset();
      Nouns[i].choose();
      Nouns[i].lifting();
      if (Nouns[i].chosen && mousePressed) {
        Nouns[i].makeFall();
      }
    }
    if (Nouns[i].falling) {
      Nouns[i].fall();
      Nouns[i].checkPoem();
    }

    //checking for Verbs
    if (!Verbs[i].falling) {
      Verbs[i].checkReset();
      Verbs[i].choose();
      Verbs[i].lifting();
      if (Verbs[i].chosen && mousePressed) {
        Verbs[i].makeFall();
      }
    }
    if (Verbs[i].falling) {
      Verbs[i].fall();
      Verbs[i].checkPoem();
    }

    //checking for adverbs
    if (!Adverbs[i].falling) {
      Adverbs[i].checkReset();
      Adverbs[i].choose();
      Adverbs[i].lifting();
      if (Adverbs[i].chosen && mousePressed) {
        Adverbs[i].makeFall();
      }
    }
    if (Adverbs[i].falling) {
      Adverbs[i].fall();
      Adverbs[i].checkPoem();
    }
    //if (Adverbs[i].falling && Adverbs[i].poem) {
    //  Adverbs[i].checkPoem();
    //}
  }
  textFont(f, 15);
  text("YOUR POEM", 700, 50);
}


class Word {
  PVector pos;
  String stuff;
  PVector vel = new PVector(0, 1);
  PVector gravity = new PVector(0, 0.1);
  float drag = 1-0.01;
  boolean falling = false;
  boolean chosen = false;
  boolean poem = false;
  float angularSpeed;
  float angle = 0;

  color c = 0;
  color fallingColor = 0;

  Word(PVector Pos, String Stuff, float angularspeed) {
    pos = Pos;
    stuff = Stuff;
    angularSpeed = angularspeed; //should make each word spin at a different rate
  }


  //call this function to make the word start to fall
  void makeFall() {
    falling = true;
  }


  //makes it so that if the mouse is within a radius of the word, then it can be chosen
  void choose() {
    if (dist(pos.x, pos.y, mouseX, mouseY) <= 50) {
      chosen = true; 
      c = color(200, 0, 0); //changes color of word to show it's selected
    } else {
      chosen = false; 
      c = 0; //changes color of word to show it's not selected
    }
  }


  //what happens when the words are going up (they spin and move slowly up)
  void lifting() {
    textFont(f, size);
    pos.y-=1; //makes the word go up
    fill(c);
    textAlign(CENTER);
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(angle);
    text(stuff, 0, 0);
    popMatrix();
    angle += angularSpeed;
  }

  void fall() {
    textFont(f, size);
    pos.add(vel);
    vel.add(gravity);
    vel.mult(drag);
    fill(fallingColor);
    text(stuff, pos.x, pos.y);
  }

  void checkPoem() {
    if (pos.y >= height) {
      textFont(f, size);
      pos.x = 650;
      pos.y = poemPlace;
      vel.mult(0);
      gravity.mult(0);
      poemPlace += 50;
      poem = true;
    }
  }

  void checkReset() {
    if (pos.y <= 0) {
      pos.y = height;
    }
  }
}
