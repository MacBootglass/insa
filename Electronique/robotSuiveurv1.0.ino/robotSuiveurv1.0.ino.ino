#include <CMUcam4.h> 
#include <CMUcom4.h> 
#include <Servo.h> 


//RGB détécté par la CMUCAM4 
#define RED_MIN 120 
#define RED_MAX 255 
#define GREEN_MIN 0 
#define GREEN_MAX 60 
#define BLUE_MIN 0 
#define BLUE_MAX 60

//Paramètres CMUCAM4 
#define GAIN_CONTROL false 
#define WHITE_BALANCE false 
#define POURCENTAGE_MIN_DETECTION_COULEUR 20 
#define POURCENTAGE_COR_DETECTION_COULEUR 40 
#define POURCENTAGE_MAX_DETECTION_COULEUR 80 
#define X_MAX 159 
#define Y_MAX 119 
#define H_ZONE_CENTRALE 15 
#define L_ZONE_CENTRALE 20

#define LED_BLINK 5    // 5 Hz 
#define WAIT_TIME 1000 // 1 seconds

//PIN utilisés 
#define PIN_HORIZ 9    // On définie le servo-moteur permettant un déplacement horizontal sur le pin 9 
#define PIN_VERTI 10   // On définie le servo-moteur permettant un déplacement vertical sur le pin 10 
#define PIN_ROUE_D 3   // On définie le servo-moteur permettant de faire tourner la roue droite sur le pin 3 
#define PIN_ROUE_G 11  // On définie le servo-moteur permettant de faire tourner la roue gauche sur le pin 11


//Amplitude maximale des servos moteurs du ras
#define VERTI_MAX 150 
#define VERTI_MIN 30 
#define HORIZ_MAX 135 
#define HORIZ_MIN 45 


//Variables 
CMUcam4 cam(CMUCOM4_SERIAL); 
CMUcam4_tracking_data_t data; 

Servo Servo_Roue_D; 
Servo Servo_Roue_G;
Servo Servo_Verti;
Servo Servo_Horiz;




void setup() { 
  cam.begin();
  cam.LEDOn(LED_BLINK); 
  delay(WAIT_TIME);
  cam.autoGainControl(GAIN_CONTROL); 
  cam.autoWhiteBalance(WHITE_BALANCE);
  cam.LEDOn(CMUCAM4_LED_ON); 
  
  Servo_Roue_D.attach(PIN_ROUE_D); 
  Servo_Roue_G.attach(PIN_ROUE_G); 
   
  Servo_Verti.attach(PIN_VERTI); 
  Servo_Horiz.attach(PIN_HORIZ); 
  
  Servo_Verti.write(135); 
  Servo_Horiz.write(90); 
  
  Serial.begin(9600); 
}






void loop() { 

  char dir = 'x';
  int angleVertical;
  int angleHorizontal;
  
  if (data.pixels > POURCENTAGE_MAX_DETECTION_COULEUR) 
    dir = 'r';
  else if (data.pixels > POURCENTAGE_MIN_DETECTION_COULEUR)
    dir = 'a';
  
  if ( dir != 'x' &&
       data.mx <= ((X_MAX + 1) / 2 + L_ZONE_CENTRALE - 1) &&
       data.mx >= ((X_MAX + 1) / 2 - L_ZONE_CENTRALE - 1) &&
       data.my <= ((Y_MAX + 1) / 2 - H_ZONE_CENTRALE - 1) &&
       data.my >= ((Y_MAX + 1) / 2 - H_ZONE_CENTRALE - 1)) {
         
      angleVertical = Servo_Verti.read() + Y_MAX/2 - data.my;
      angleHorizontal = Servo_Horiz.read() + Y_MAX/2 - data.my;   
      
      if (angleVertical <= VERTI_MAX && angleVertical >= VERTI_MIN)
        Servo_Verti.write(angleVertical);     
      
      if (angleHorizontal <= HORIZ_MAX && angleHorizontal >= HORIZ_MIN) {
        Servo_Horiz.write(angleHorizontal);
        
      deplacement(dir, 500);
    } 
  }
}



void deplacement(char dir, int temps) { 
  /* 
     - a pour avancer 
     - r pour reculer 
     - d pour tourner à droite d'un angle de ? 
     - g pour tourner à gauche d'un angle de ? 
  */ 
    
    
   int posRoueG; 
   int posRoueD; 
   
   if (temps > 180) 
     temps = 180; 
   
   if (temps < 0) 
     temps = 0; 
   
   switch (dir) { 
     case 'a': 
       posRoueG = 90; 
       posRoueD = 0; 
       break; 
     case 'r': 
       posRoueG = 0; 
       posRoueD = 90; 
       break; 
     case 'd': 
       posRoueG = 90; 
       posRoueD = 90; 
       break; 
     case 'g': 
       posRoueG = 0; 
       posRoueD = 0; 
       break; 
  } 
  
  Servo_Roue_G.write(posRoueG); 
  Servo_Roue_D.write(posRoueD); 
  
  delay(temps);
}

