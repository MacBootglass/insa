package fr.insarouen.asi.minigimp;

import java.awt.*;

// **************************************
// class Figure
// **************************************
abstract class Figure implements Dessinable {
  private static int compteur = 0;
  
  private int numero;
  private Color couleur;

  // constructeurs
  Figure() {
    numero  = compteur++;  // affectation puis incrementation
    couleur = Color.white;
  }

  Figure(Color _couleur) {
    this();
    couleur = _couleur;
  }
  
  // méthodes
  abstract double getPerimetre();
  abstract double getSurface();

  public int getNumero() {
    return numero;
  }

  public static int getNbfigures() {
    return compteur;
  }

  public Color getCouleur() {
    return couleur;
  }
  public void setCouleur(Color _couleur) {
    couleur = _couleur;
  }

  public String toString() {
    return "Figure "+getNumero()+" "+getCouleur();
  }
}

