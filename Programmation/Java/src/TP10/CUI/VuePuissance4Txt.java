package TP10.CUI;

import TP10.App.*;
import java.util.Observer;
import java.util.Observable;

public class VuePuissance4Txt implements Observer{
  Puissance4 p4;
  int hauteur;
  int largeur;
  public VuePuissance4Txt(Puissance4 p4) {
    this.p4 = p4;
    this.hauteur = p4.getHauteur();
    this.largeur = p4.getLargeur();
    this.p4.addObserver(this);
  }

  public void afficher() {
    char jeton = ' ';
    StringBuilder str = new StringBuilder();

    for (int i = this.hauteur; i >= -1; i--) {
      for (int j = 0; j < this.largeur; j++) {
        if (i == -1)
          str.append("--");

        if (i == hauteur)
          str.append(String.format(" %d", j));

        if (i >= 0 && i < this.hauteur) {
          switch (this.p4.getJeton(j, i)) {
            case VIDE:
              jeton = ' ';
              break;
            case ROUGE:
              jeton = 'X';
              break;
            case JAUNE:
              jeton = 'O';
              break;
          }
          str.append(String.format("|%c", jeton));
        }
      }

      if (i >= 0 && i < this.hauteur)
        str.append("|\n");

      if (i == -1)
        str.append("-\n");

      if (i == hauteur)
        str.append(" \n");
    }
    System.out.println(str.toString());
  }

  public void update(Observable o, Object ob) {
    this.afficher();
  }

  public static void main(String[] arg) {
    Puissance4 p4 = new Puissance4(5, 6);
    VuePuissance4Txt vp4 = new VuePuissance4Txt(p4);
    try {
      p4.joueColonne(3);
      p4.joueColonne(3);
      p4.joueColonne(4);
    }
    catch(Puissance4ColonneException e) {
      System.out.println(e);
    }
  }
}
