/*
 * Main.java
 *
 * Created on 20 juin 2006, 17:26
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */

package TP11;

import java.awt.Container;
import java.awt.FlowLayout;
import javax.swing.JFrame;

/**
 *
 * @author nicolas
 */
public class Main {

    public static void main(String[] args) {
        Feu feu = new Feu(Feu.Etat.ARRET);

        AffichageFeu affichageFeu = new AffichageFeu(feu);
        JFrame frameAfficheFeu= new JFrame("Feux");
        frameAfficheFeu.setContentPane(affichageFeu);
        frameAfficheFeu.pack();
        frameAfficheFeu.setVisible(true);

        AffichageFeu affichageFeu2 = new AffichageFeu(feu);
        JFrame frameAfficheFeu2= new JFrame("Feux");
        frameAfficheFeu2.setContentPane(affichageFeu2);
        frameAfficheFeu2.pack();
        frameAfficheFeu2.setVisible(true);



        JFrame controleurFeu = new JFrame("ControleurFeu");
        controleurFeu.setContentPane(new ControleurFeuGraphique(feu));
        controleurFeu.pack();
        controleurFeu.setVisible(true);

        //ControleurFeuAuto controleurFeuAuto = new ControleurFeuAuto(feu,1,2,3);
        //new Thread(controleurFeuAuto).start();


    }
}
