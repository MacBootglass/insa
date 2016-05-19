package TP10.CUI;

import TP10.App.*;
import java.util.Scanner;

public class ControleurPuissance4Txt {
  private Puissance4 p4;

  public ControleurPuissance4Txt(Puissance4 p4) {
    this.p4 = p4;
  }

  public void joue() {
    Scanner sc = new Scanner(System.in);
    while (true) {
      System.out.println("\nSaisir colonne:");
      try {
        this.p4.joueColonne(sc.nextInt());
      }
      catch (Puissance4ColonneException e) {
        System.out.println(e.getMessage());
      }
    }
  }
}
