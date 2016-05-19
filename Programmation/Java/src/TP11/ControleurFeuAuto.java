/*
 * ControleurFeuAuto.java
 *
 * Created on 21 juin 2006, 00:19
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */

package TP11;

import java.lang.*;

/**
 *
 * @author nicolas
 */
public class ControleurFeuAuto implements Runnable {

  private Feu feu;
  private int tpsPasse;
  private int tpsAttention;
  private int tpsArret;
  private boolean enCours;

  /** Creates a new instance of ControleurFeuAuto */
  public ControleurFeuAuto(Feu feu, int tpsPasse, int tpsAttention, int tpsArret) {
    this.feu = feu;
    this.tpsPasse = Math.abs(tpsPasse);
    this.tpsAttention = Math.abs(tpsAttention);
    this.tpsArret = Math.abs(tpsArret);
    this.enCours = true;
  }

  public void stop() {
    this.enCours = false;
  }



  public void run() {
    Thread current = Thread.currentThread();
    while (this.enCours) {
      try {
        switch (this.feu.getEtat()) {
          case PASSE :
            this.feu.setEtat(Feu.Etat.ATTENTION);
            current.sleep(this.tpsAttention);
            break;

          case ATTENTION:
            this.feu.setEtat(Feu.Etat.ARRET);
            current.sleep(this.tpsArret);
            break;

          case ARRET:
            this.feu.setEtat(Feu.Etat.PASSE);
            current.sleep(this.tpsPasse);
            break;
        }
      }
      catch(InterruptedException e) {}
    }
  }
}
