import processing.sound.*;
Amplitude amp;
AudioIn in;
float ampt;

PImage bg;
color c;
float i = 1;

void setup()
{
  size(900, 900, P2D);
  bg = loadImage("one.jpg");
  //bg = loadImage("two.jpg");
 
  bg.resize(width, height);
  image(bg, 0, 0);
  background(0);
  frameRate(30);


  amp = new Amplitude(this); // Creating an Input stream which is routed into the Amplitude analyzer
  in = new AudioIn(this, 0);
  in.start();
  amp.input(in);
}

int count = 0;
void draw() 
{

  ampt = amp.analyze();
  println(ampt);
  if (ampt >= 0.1) {

    for (int x = 0; x < bg.width; x+=4) {
      for (int y = 0; y < bg.height; y+=4) {
        c = bg.get(x, y); //get the colour value of the pixel at that location
        float b = brightness(c); // create a float that stores the brightness of that colour
        b = map(b, 0, 255, 15, 5); // map a value to b that is between 0-255 and 15-5
        smooth(); //anti aliased edges
        fill(c, 50); //fill the shapes with the colour value at 50 opactiy
        stroke(c); //use that stroke
        translate(i, i); //move it dow and right
        ellipse(x, y, b, b+5); //create a circle at the pixel we got the colour from and make a circle
      }
    }
  } else if (ampt >= 0.02) {

    for (int x = 0; x < bg.width; x+=8) {
      for (int y = 0; y < bg.height; y+=8) {
        c = bg.get(x, y);
        float b = brightness(c);
        b = map(b, 0, 255, 15, 5);
        smooth();
        fill(c, 20);
        stroke(c);
        pushMatrix();
        translate(i, i);
        ellipse(x, y, b, b+5);
        tint(255, 75);
        popMatrix();
        i++;
        if (i > 60) i = 0;
      }
    }
  } else {
    image(bg, 0, 0 );
  }
}
void keyPressed() {
  saveFrame("frame-######.png");
}
