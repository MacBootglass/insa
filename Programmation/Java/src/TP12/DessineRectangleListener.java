package TP12;

import javax.swing.*;
import java.awt.*;
import java.awt.event.*;

// TODO Listener qui modifie les données (dessinables) lors d'un click dans la zone de dessin
public class DessineRectangleListener extends MouseAdapter {
  private final static int MAX_LENGTH = 50;

  private DessinablesData dessinables;

  public DessineRectangleListener(DessinablesData dessinables) {
    this.dessinables = dessinables;
  }

  public void mouseClicked(MouseEvent e){
    int largeur = Utilitaires.getIntAlea_1_Max(MAX_LENGTH);
    int hauteur = Utilitaires.getIntAlea_1_Max(MAX_LENGTH);
    Color coul =  new Color(Utilitaires.getIntAlea_1_Max(256)-1, Utilitaires.getIntAlea_1_Max(256)-1, Utilitaires.getIntAlea_1_Max(256)-1);
    Rectangle c = new Rectangle(e.getX(), e.getY(), e.getX() + largeur, e.getY() + hauteur, coul);
    dessinables.addDessinable(c);
  }
}
