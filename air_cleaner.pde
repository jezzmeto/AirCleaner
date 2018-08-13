import de.voidplus.leapmotion.*;
import gifAnimation.*;
import processing.video.*;
import processing.sound.*;
import ddf.minim.*;
Minim minim;
AudioPlayer factorySound;
AudioPlayer trafficSound;
Gif factoryGif;
Gif taiwanGif;
Movie movie;

float a = 230;
int factoryExit = 0;
float oldTime;
LeapMotion leap;

int playing;
int playingTime = 3*60;

//state
final int START = 0, OPENING = 1, DESCRIPTION = 2, TAIWAN_POLLUTION = 3, FACTORY = 4, TRAFFIC = 5, TAIWAN_CLEAN = 6, END = 7;
int state = 0 ;

//START
PImage cover;

//TWIWAN
PImage taipei0, taipei1, kaohsiung0, kaohsiung1;
PImage exit_t0, exit_t1, exit_f0, exit_f1, exit_f, exit_t;
PImage factory0;
PImage traffic, traffic0;
PImage taiwanClean;
PImage brownCar, orangeCar, sliverCar, blackCar, whiteCar, redCar;
PImage fence;
PImage discreption, source;
int pollution_a;

//START_BUTTON
final int START_BUTTON_WIDTH = 120;
final int START_BUTTON_HEIGHT = 75;
final int START_BUTTON_X = 880;
final int START_BUTTON_Y = 665;

//SPOT
final int SPOT_WIDTH = 40;
final int SPOT_HEIGHT = 70;
final int PHOTO_WIDTH = 300;
final int PHOTO_HEIGHT = 220;

//TAIPEI SPOT
final int TAIPEI_SPOT_X = 580;
final int TAIPEI_SPOT_Y = 20;


//KAOHSIUNG SPOT
final int KAOHSIUNG_SPOT_X = 380;
final int KAOHSIUNG_SPOT_Y = 523;

//EXIST_BUTTON
final int EXIT_BUTTON_WIDTH = 90;
final int EXIT_BUTTON_HEIGHT = 50;
final int EXIT_BUTTON_X = 900;
final int EXIT_BUTTON_Y = 685;
final int EXIT_WORD_WIDTH = 138;
final int EXIT_WORD_HEIGHT = 40;
final int EXIT_WORD_X = 875;
final int EXIT_WORD_Y = 643;

//Traffic
    float brownCar_X = 466.4;
    float brownCar_Y = 335.093;
    float orangeCar_X = 334.013;
    float orangeCar_Y = 355.167;
    float sliverCar_X = 11.999;
    float sliverCar_Y = 365.667;
    float blackCar_X = 201.516;
    float blackCar_Y = 458.049;
    float whiteCar_X = 743.327;
    float whiteCar_Y = 335.093;
    float redCar_X = 861.483;
    float redCar_Y = 339.837;

void setup(){
  
  size(1024,760, P3D);
  //load Image
  cover = loadImage("img/cover.jpg");
  taipei0 = loadImage("img/taipei0.png");
  taipei1 = loadImage("img/taipei1.png");
  kaohsiung0 = loadImage("img/kaohsiung0.png");
  kaohsiung1 = loadImage("img/kaohsiung1.png");
  exit_t0 = loadImage("img/exit_t0.png");
  exit_t1 = loadImage("img/exit_t1.png");
  exit_f0 = loadImage("img/exit_f0.png");
  exit_f1 = loadImage("img/exit_f1.png");
  exit_f = loadImage("img/exit_f.png");
  exit_t = loadImage("img/exit_t.png");
  
  factory0 = loadImage("img/factory0.jpg");
  traffic0 = loadImage("img/traffic0.jpg");
  
  factoryGif = new Gif(this,"img/factory.gif");
  factoryGif.play();
  
  taiwanGif = new Gif(this,"img/taiwan.gif");
  taiwanGif.play();
  
  traffic = loadImage("img/traffic.jpg");

  brownCar = loadImage("img/brownCar.png");
  orangeCar = loadImage("img/orangeCar.png");
  sliverCar = loadImage("img/sliverCar.png");
  blackCar = loadImage("img/blackCar.png");
  whiteCar = loadImage("img/whiteCar.png");
  redCar = loadImage("img/redCar.png");
  fence = loadImage("img/fence.png");
  taiwanClean = loadImage("img/taiwanClean.png");

  discreption = loadImage("img/discreption.jpg");
  source = loadImage("img/source.jpg");
  
  movie = new Movie(this, "opening.mp4");
  
  //Load Audio
  minim = new Minim(this);
  factorySound = minim.loadFile("factory.mp3");
  trafficSound = minim.loadFile("traffic.mp3");
  
  leap = new LeapMotion(this);
  
}

void draw(){
  switch(state){
    case START:
      image(cover,0,0,1024,760);
      
      if (mousePressed) {
        state = OPENING;
        }
    break;
    
    case OPENING:
      movie.play();
      image(movie, 0, 0, width, height);
      float mt = movie.time(); 
      if( mt >= 43){
        state = DESCRIPTION;
      }
    break;
    
    case DESCRIPTION:
      image(discreption, 0, 0, width, height);
      
      if (mousePressed) {
        state = TAIWAN_POLLUTION;
      }
    break;
    
    case TAIWAN_POLLUTION:
      pollution_a = 175;
      image(taiwanGif, 0, 0, 1024, 760);
      
      if( playing == 2){
        pollution_a -= 50;
      }
      
      
      noStroke();
      fill(105, 105, 105, pollution_a);
      rect(0,0,1024,760);
      
      
      //taipei
      if (isMouseHit(TAIPEI_SPOT_X, TAIPEI_SPOT_Y, SPOT_WIDTH, SPOT_HEIGHT)) {
        image(taipei1, TAIPEI_SPOT_X, TAIPEI_SPOT_Y, SPOT_WIDTH, SPOT_HEIGHT); 
        image(traffic0, 95, 45,PHOTO_WIDTH, PHOTO_HEIGHT); 
        if (mousePressed) {
          state = TRAFFIC;
          playing += 1;
          mousePressed = false;
          }
        } else {
          image(taipei0, TAIPEI_SPOT_X, TAIPEI_SPOT_Y, SPOT_WIDTH, SPOT_HEIGHT);
        }
      
      //kaohsiung
      if (isMouseHit(KAOHSIUNG_SPOT_X, KAOHSIUNG_SPOT_Y, SPOT_WIDTH, SPOT_HEIGHT)) {
        image(kaohsiung1, KAOHSIUNG_SPOT_X, KAOHSIUNG_SPOT_Y, SPOT_WIDTH, SPOT_HEIGHT); 
        image(factory0, 610, 500,PHOTO_WIDTH, PHOTO_HEIGHT); 
        if (mousePressed) {
          state = FACTORY;
          playing += 1;
          mousePressed = false;
          }
        } else {
          image(kaohsiung0, KAOHSIUNG_SPOT_X, KAOHSIUNG_SPOT_Y, SPOT_WIDTH, SPOT_HEIGHT);
        }
        
    break;
    
    ////////////////////////// KAOHSIUNG //////////////////////////
    case FACTORY:
      image(factoryGif, 0, 0, 1024, 760);
      noStroke();
      fill(174,139,102,a);
      rect(0,0,1024,760);
      //Control sound
      if(a==0){
        factorySound.pause();
      }else{
        factorySound.play();
      }
      
      println ("countHand" + leap.countHands());
      int countHands = leap.countHands();
      
      if(countHands == 0 && a > 0){
        println("NOOOOO HAAAND");
        a += 2; 
        if(a >= 230){
          a = 230;
        }
        println(a);
       }
       
     ////////////////////////// LEAPMOTION FINGER CONTROL //////////////////////////
     if(countHands >= 1){
      for(Hand hand : leap.getHands()){
        //hand.draw();
        PVector handPosition = hand.getPosition();
          for(Finger finger : hand.getFingers()){
            //finger.draw();
            finger.drawBones();
            PVector fingerVelocity   = finger.getVelocity();
            //float finger_time = finger.getTimeVisable();
            //println(fingerVelocity.y);
            //println(handPosition);
            println(a);
            
          if(a > 0){
            if ((abs(fingerVelocity.x) + abs(fingerVelocity.z) + abs(fingerVelocity.y)) > 3000){
              a -= 2;
              if (a <= 0){
                a = 0;
              }
            }else{
              a += 2;
              if (a >= 230){
                a = 230;
              }
            }
           }
          }
      }
     }
      if(a == 0){
        factoryExit +=1 ;
      }
      

     //exit
     
     if(factoryExit > 0){ 
       image(exit_f, EXIT_WORD_X, EXIT_WORD_Y, EXIT_WORD_WIDTH, EXIT_WORD_HEIGHT);
       if (isMouseHit(EXIT_BUTTON_X, EXIT_BUTTON_Y, EXIT_BUTTON_WIDTH, EXIT_BUTTON_HEIGHT)) {
          image(exit_f1, EXIT_BUTTON_X, EXIT_BUTTON_Y, EXIT_BUTTON_WIDTH, EXIT_BUTTON_HEIGHT); 
          if (mousePressed) {
            playing +=1;
            mousePressed = false;
            }
          } else {
            image(exit_f0, EXIT_BUTTON_X, EXIT_BUTTON_Y, EXIT_BUTTON_WIDTH, EXIT_BUTTON_HEIGHT);
          }
     }
     if(playing == 2){
       state = TAIWAN_POLLUTION;
     }
     if(playing == 4){
       state = TAIWAN_CLEAN;
     }

    break;
    
    ////////////////////////// TAIPEI //////////////////////////
    case TRAFFIC:
      float b = map(sliverCar_X, 11.999 , -439.227, 230, 0);
      if(b<=0){
        trafficSound.pause();
      }else{
        trafficSound.play();
      }

      image(traffic, 0, 0, 1024,760);
      image(brownCar, brownCar_X, brownCar_Y, 157.196, 118.32);
      image(orangeCar, orangeCar_X, orangeCar_Y, 264.774, 196.49);
      image(sliverCar, sliverCar_X, sliverCar_Y, 439.227, 323.234);
      image(blackCar, blackCar_X, blackCar_Y, 647.968, 451.931);
      image(whiteCar, whiteCar_X, whiteCar_Y, 182.887, 170.991);
      image(fence, 692.796, 385, 130.363, 193.915);
      image(redCar, redCar_X, redCar_Y, 365.659, 374.893);

      noStroke();
      fill(105,105,105, b);
      rect(0,0,1024,760);
      for(Hand hand : leap.getHands()){
        //hand.draw();

          for(Finger finger : hand.getFingers()){
            //finger.draw();
            finger.drawBones();
            
            PVector fingerVelocity   = finger.getVelocity();
            //float finger_time = finger.getTimeVisable();
            //println("fingerVelocity "+fingerVelocity.y);
            println(b);

            if ( abs(fingerVelocity.y) > 1000){
              blackCar_Y += 2;
              
              orangeCar_X -= 3 * 0.25;
              orangeCar_Y -= 1 * 0.25;
              whiteCar_X += 2.5 * 0.25;
              whiteCar_Y -= 1 * 0.25;
              
              if(orangeCar_X < 400){
                brownCar_Y -= 2 * 0.25;
              }
              if(whiteCar_X > 900){
                redCar_X += 1.5 * 0.25;
              }
              if(blackCar_Y > 670){
                sliverCar_X -= 2 * 0.25;
              }
              if(blackCar_Y > 900){
                blackCar_Y = 1100;
              }
              if(sliverCar_X < -500){
                sliverCar_X = -600;
              }
              if(orangeCar_X < -500){
                orangeCar_X = -500;
              }
              if(brownCar_Y < -200){
                brownCar_Y = -800;
              }
            if(whiteCar_X > 1100){
                whiteCar_X = 1200;
              }
            if(redCar_X > 1100){
                redCar_X = 1200;
              }
              }
            }
          }

     //exit
     if(b <= 0){
       image(exit_t, EXIT_WORD_X, EXIT_WORD_Y, EXIT_WORD_WIDTH, EXIT_WORD_HEIGHT);
       if (isMouseHit(EXIT_BUTTON_X, EXIT_BUTTON_Y, EXIT_BUTTON_WIDTH, EXIT_BUTTON_HEIGHT)) {
          image(exit_t1, EXIT_BUTTON_X, EXIT_BUTTON_Y, EXIT_BUTTON_WIDTH, EXIT_BUTTON_HEIGHT); 
          if (mousePressed) {
            playing +=1;
            mousePressed = false;
            }
          } else {
            image(exit_t0, EXIT_BUTTON_X, EXIT_BUTTON_Y, EXIT_BUTTON_WIDTH, EXIT_BUTTON_HEIGHT);
          }        
        }
        
     if(playing == 2){
       state = TAIWAN_POLLUTION;
     }
     if(playing == 4){
       state = TAIWAN_CLEAN;
     }
        
    break;
    
    case TAIWAN_CLEAN:
      image(taiwanClean, 0, 0, width, height);
      playingTime --;
      println(playingTime);
      if( playingTime <= 0 ){
        state = END;
      }
    break;
    
    case END:
      image(source, 0, 0, width, height);
    break;
    
    
  }
}


void movieEvent(Movie m) {
  m.read();
}

boolean isMouseHit(float bx, float by, float bw, float bh) {
  return  mouseX > bx && 
          mouseX < bx + bw && 
          mouseY > by && 
          mouseY < by + bh;
      }