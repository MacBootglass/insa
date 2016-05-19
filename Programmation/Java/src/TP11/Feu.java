/*
 * Feu.java
 *
 * Created on 20 juin 2006, 17:04
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */

package TP11;

import java.util.Observable;

/**
 *
 * @author nicolas
 */
public class Feu extends Observable {

    public enum Etat {PASSE,ATTENTION,ARRET};

    private Etat etat;

    /** Creates a new instance of Feu */
    public Feu(Etat etat) {
        this.etat = etat;
    }

    public Etat getEtat() {
        return etat;
    }

    public void setEtat(Etat etat) {
        if (this.etat == etat)
            return;
        this.etat = etat;
        setChanged();
        notifyObservers();

    }

}
