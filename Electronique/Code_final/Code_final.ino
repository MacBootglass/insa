#include <CMUcam4.h>
#include <CMUcom4.h>
#include <Servo.h>

#define LED_BLINK 5 // fréquence d'allumage de la led sur la cmucam4
#define WAIT_TIME 5000 // 5 seconds

/*-----------------------*/

/*define des pins des LED */

//#define LED_GREEN 6 // On définie la led verte sur le pin 6
#define LED_RED 7 // On définie la led rouge sur le pin 7
//#define LED_BLUE 10 // On définie la led bleue sur le pin 10
//#define LED_YELLOW 12 // On définie la led jaune sur le pin 12

/*-----------------------*/

/*define des pins des servo-moteurs */

#define PIN_HORIZ 9 // On définie le servo-moteur permettant un déplacement horizontal sur le pin 9
#define PIN_VERTI 10 // On définie le servo-moteur permettant un déplacement vertical sur le pin 10
#define PIN_ROUE_D 3 // On définie le servo-moteur permettant de faire tourner la roue droite sur le pin 3
#define PIN_ROUE_G 11 // On définie le servo-moteur permettant de faire tourner la roue gauche sur le pin 11

/*-----------------------*/

/* define des bornes moteur, les servo-moteur déplaçant la cmucam4 sont limités en angle dans leurs caractéristique set par le montage*/

#define VERTI_MAX 150 // On définie le max pour le déplacement vertical
#define VERTI_MIN 30 // On définie le min pour le déplacement vertical
#define HORIZ_MAX 170 // On définie le max pour le déplacement horizontal
#define HORIZ_MIN 10 // On définie le min pour le déplacement horizontal

/*-----------------------*/

/*define pour les coordonnées de la fenetre regardée par la cmucam4 */

#define X_MAX_SCREEN 159 // coordonnée max en x
#define Y_MAX_SCREEN 119 // coordonnée max en y

#define X_MID 79 // coordonnée moyenne en x
#define Y_MID 60 // coordonnée moyenne en y

#define angle_x_max 10
#define angle_y_max 5

/*-----------------------*/

/* déclaration de toute les variables */

CMUcam4 cam(0); // variable pour la cmucam4

Servo Servo_Verti, Servo_Horiz; // moteurs caméra
Servo Servo_Roue_D, Servo_Roue_G; // moteurs des roues

int cam_X, cam_Y; // position des pixels recherchés dans l'image
int pos_servo_h = 90, pos_servo_v = 90; // position des moteurs camera (initialisation a 90)
int pcent_pixel; // pourcentage de pixel de la couleur recherchée dans l'écran

CMUcam4_tracking_data_t data; // variable renvoyée par la cmucam4 après acquisition

int lightRed; // variable représentant l'état des led
//int lightGreen, lightBlue, lightYellow; // variable représentant l'état des led

boolean bouge = false; // booleen permettant la remise en place de la cmucam4 après rotation sur les deux moteur des roues

/*-----------------------*/

//-------------------------------------------------------------//
// Fonction d'initialisation 
//-------------------------------------------------------------//
void setup() {

  cam.begin(); // initialisation de la cmucam4
  cam.LEDOn(LED_BLINK); // active la led de la cmucam4 et la fait clignoter à la fréquence de LED_BLINK, ici 5 Hz
  
  delay(WAIT_TIME); // Un simple délai pour permettre la confirmation visuelle de l'initialisation 
  
  cam.autoGainControl(false); // desactivation de l'ajustement automatique de la luminosité (gain en rapidité)
  cam.autoWhiteBalance(false); // desactivation de la balance ddes blancs automatique (gain en rapidité)

  cam.LEDOn(CMUCAM4_LED_ON); // On passe la fréquence de la led à 0 Hz
  
  // On fixe les LED sur les différent port 
  
  pinMode(LED_RED, OUTPUT); // permet de fixer le pin LED_RED en sortie
//  pinMode(LED_GREEN, OUTPUT); // permet de fixer le pin LED_GREEN en sortie     
//  pinMode(LED_BLUE, OUTPUT); // permet de fixer le pin LED_BLUE en sortie
//  pinMode(LED_YELLOW, OUTPUT); // permet de fixer le pin LED_YELLOW en sortie

  // On fixe les moteur des roues sur leurs pins respectifs 
  
  Servo_Verti.attach(PIN_VERTI); // On fixe la variable Servo_Verti sur le pin PIN_VERTI
  Servo_Horiz.attach(PIN_HORIZ); // On fixe la variable Servo_Horiz sur le pin PIN_HORIZ
  Servo_Roue_D.attach(PIN_ROUE_D); // On fixe la variable Servo_Roue_D sur le pin PIN_ROUE_D
  Servo_Roue_G.attach(PIN_ROUE_G); // On fixe la variable Servo_Roue_G sur le pin PIN_ROUE_G
}


//-------------------------------------------------------------//
// Fonction Principale
//-------------------------------------------------------------//

void loop() {
  

  cam.trackColor(120,255,0,60,0,60);// Fixe les paramètre de recherche, ici dans le rouge.
  
  Servo_Roue_D.detach(); //On détache la variable Servo_Roue_D de son pin
  Servo_Roue_G.detach(); //On détache la variable Servo_Roue_G de son pin
  
  for(;;){
    
    lightRed = LOW; // On met la led rouge sur LOW (éteinte)
//    lightGreen = LOW; // On met la led verte sur LOW (éteinte)
//    lightBlue = LOW; // On met la led bleue sur LOW (éteinte)
//    lightYellow = LOW; // On met la led jaune sur LOW (éteinte)

    cam.getTypeTDataPacket(&data);     // On récupère les infos transmises par la cmucam4
    
    if(data.pixels > 1) { // Si on capte un minimum de la couleur recherchée, on regarde si une action est nécéssaire 
      
      lightRed = HIGH; // On met la varuable lightRed sur HIGH (permetera d'allumer la led rouge)
      cam_X = data.mx; // On récupère la coordonnée en x du barycentre des pixels de la couleur recherchée
      cam_Y = data.my; // On récupère la coordonnée en y du barycentre des pixels de la couleur recherchée
      pcent_pixel = data.pixels; // On récupère le pourcentage de pixels de la couleur recherchée dans l'écran  [0 ; 255]
      
      if((cam_X<X_MID+20)&&(cam_X>X_MID-20)&&(cam_Y<Y_MID+15)&&(cam_Y>Y_MID-15)){ //Si on se trouve dans la zone tampon (=1/4 de la surface de l'image)
      
        if (pcent_pixel < 10){  // Si on est trop loin on avance (un faible pourcentage de la couleur capté)
          
          Servo_Roue_D.attach(PIN_ROUE_D); // On fixe la variable Servo_Roue_D sur le pin PIN_ROUE_D
          Servo_Roue_G.attach(PIN_ROUE_G); // On fixe la variable Servo_Roue_G sur le pin PIN_ROUE_G
          Servo_Roue_G.write(180); // avancer
          Servo_Roue_D.write(0); // avancer
          delay(300); // On laisse les moteurs actifs pendant 300 ms
          Servo_Roue_D.detach(); //On détache la variable Servo_Roue_D de son pin
          Servo_Roue_G.detach(); //On détache la variable Servo_Roue_G de son pin
          
        }
        else if (pcent_pixel > 150){ // Si on est trop près on recule
          
          Servo_Roue_D.attach(PIN_ROUE_D); // On fixe la variable Servo_Roue_D sur le pin PIN_ROUE_D
          Servo_Roue_G.attach(PIN_ROUE_G); // On fixe la variable Servo_Roue_G sur le pin PIN_ROUE_G
          Servo_Roue_G.write(0); // reculer
          Servo_Roue_D.write(180); // reculer
          delay(300); // On laisse les moteurs actifs pendant 300 ms
          Servo_Roue_D.detach(); //On détache la variable Servo_Roue_D de son pin
          Servo_Roue_G.detach(); //On détache la variable Servo_Roue_G de son pin
          
        }
      }
      else { //Si on ne se trouve pas dans la zone tampon (=1/4 de la surface de l'image)
        
        if(cam_X < X_MID){ // Si la couleur se trouve en haut (à gauche dans le référentiel de la cmucam4)
        
          if (cam_Y > Y_MID){ // Si la couleur se trouve à droite (en haut dans le référentiel de la cmucam4)
          
            pos_servo_h=pos_servo_h - (((cam_Y - Y_MID)*angle_y_max)/Y_MID); // On calcule la nouvelle position horizontale (dégrée pour le moteur)
          }
          else if (cam_Y < Y_MID){  // Si la couleur se trouve à gauche (en bas dans le référentiel de la cmucam4)
         
            pos_servo_h=pos_servo_h + (((Y_MID - cam_Y)*angle_y_max)/Y_MID); // On calcule la nouvelle position horizontale (dégrée pour le moteur)
          }
          pos_servo_v=pos_servo_v + (((X_MID - cam_X)*angle_x_max)/X_MID); // On calcule la nouvelle position verticale (dégrée pour le moteur)
        }
        else if (cam_X > X_MID){ // Si la couleur se trouve en bas (à droite dans le référentiel de la cmucam4)
      
          if (cam_Y < Y_MID){ // Si la couleur se trouve à gauche (en bas dans le référentiel de la cmucam4)      

            pos_servo_h=pos_servo_h + (((Y_MID - cam_Y*angle_y_max))/Y_MID); // On calcule la nouvelle position horizontale (dégrée pour le moteur)
          } 
          else if (cam_Y > Y_MID){ // Si la couleur se trouve à droite (en haut dans le référentiel de la cmucam4)
        
            pos_servo_h=pos_servo_h - (((cam_Y - Y_MID)*angle_y_max)/Y_MID); // On calcule la nouvelle position horizontale (dégrée pour le moteur)
          }
        
          pos_servo_v=pos_servo_v - (((cam_X - X_MID)*angle_x_max)/X_MID); // On calcule la nouvelle position verticale (dégrée pour le moteur)
                
        }
     
        if (pos_servo_v < VERTI_MIN){ // Si on est en-dessous de la borne min, on revient dans les bornes
          pos_servo_v = VERTI_MIN;
        } 
        else if (pos_servo_v > VERTI_MAX){ // Sinon, si on est au dessus de la borne max, on revient dans les bornes
           pos_servo_v = VERTI_MAX; 
        }
     
        if (pos_servo_h < HORIZ_MIN){ // Si on est en-dessous de la borne min, on revient dans les bornes
          pos_servo_h = HORIZ_MIN;
        } 
        else if (pos_servo_h > HORIZ_MAX){ // Sinon, si on est au dessus de la borne max, on revient dans les bornes
          pos_servo_h = HORIZ_MAX; 
        }
        // On déplace les moteurs en fonction des nouveau angles //
        Servo_Verti.write(pos_servo_v); // On se déplace horizontalement vers l'angle souhaité
        Servo_Horiz.write(pos_servo_h); // On se déplace verticalement vers l'angle souhaité
      }
    
    
      if (pos_servo_h > 150){ // Si la caméra à ateint un angle important sur le plan horizontale, on la replace au centre et on utilise les roue pour compenser
      
        Servo_Roue_D.attach(PIN_ROUE_D); // On fixe la variable Servo_Roue_D sur le pin PIN_ROUE_D
        Servo_Roue_G.attach(PIN_ROUE_G); // On fixe la variable Servo_Roue_G sur le pin PIN_ROUE_D
        Servo_Roue_G.write(0); // reculer
        Servo_Roue_D.write(0); // avancer
        bouge=true; // on passe bouge à true pour indiquer qu'il faudra bouger le moteur horizontal
        delay(400); // On laisse les moteurs actifs pendant 400 ms
        Servo_Roue_D.detach(); //On détache la variable Servo_Roue_D de son pin
        Servo_Roue_G.detach(); //On détache la variable Servo_Roue_G de son pin
      }
      else if (pos_servo_h < 30){
        Servo_Roue_D.attach(PIN_ROUE_D); // On fixe la variable Servo_Roue_D sur le pin PIN_ROUE_D
        Servo_Roue_G.attach(PIN_ROUE_G); // On fixe la variable Servo_Roue_G sur le pin PIN_ROUE_D
        Servo_Roue_D.write(180); // reculer
        Servo_Roue_G.write(180); // avancer
        bouge=true; // on passe bouge à true pour indiquer qu'il faudra bouger le moteur horizontal
        delay(400); // On laisse les moteurs actifs pendant 400 ms
        Servo_Roue_D.detach(); //On détache la variable Servo_Roue_D de son pin
        Servo_Roue_G.detach(); //On détache la variable Servo_Roue_G de son pin
        }
      if (bouge) { // Si on a déplacé les roues, on replace la cmucam4 au centre
        pos_servo_h=90; // position horizontale mise sur un angle de 90°
        Servo_Horiz.write(pos_servo_h); // On déplace le servo
        bouge=false; // On remet bouge sur false pour ne pas se re-déplacer
      }
    }
  
    digitalWrite(LED_RED, lightRed);  // Commandes pour  allumer les LED
  }
}

/* Attention, l'acquisition dépend de l'intensité de lumière de l'environnement.
En fonction de l'endroit ou les acquisitions seront affectuées, on pourra vouloir modifier
les paramètres de luminosité avec les fonctions : cameraBrightness(), cameraContrast().
Pour plus de détail aller sur : http://www.cmucam.org/docs/cmucam4/arduino_api/functions_func.html */
