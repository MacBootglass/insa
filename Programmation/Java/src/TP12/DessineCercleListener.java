package TP12;

import java.awt.*;
import java.awt.event.*;

// TODO Listener qui modifie les données (dessinables) lors d'un click dans la zone de dessin
public class DessineCercleListener extends MouseAdapter {
  private final static int MAX_LENGTH = 50;
  private DessinablesData dessinables;

  public DessineCercleListener(DessinablesData dessinables) {
    this.dessinables = dessinables;
  }

  public void mouseClicked(MouseEvent e){
    Color coul = new Color(Utilitaires.getIntAlea_1_Max(255)-1, Utilitaires.getIntAlea_1_Max(255)-1, Utilitaires.getIntAlea_1_Max(255)-1);
    Cercle c = new Cercle(e.getX(), e.getY(), Utilitaires.getIntAlea_1_Max(MAX_LENGTH), coul);
    dessinables.addDessinable(c);
  }
}
