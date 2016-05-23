package TP12;

import javax.swing.*;
import java.awt.*;
import java.awt.event.*;
import javax.swing.event.*;

// TODO Listener qui modifie les données (dessinables) lors d'un click dans la zone de dessin
public class DessineRectangleListener extends MouseInputAdapter {

  private final static int MAX_LENGTH = 200;
  private DessinablesData dessinables;
  private Dessin dessin;
  private int x1, y1, x2, y2;
  private Graphics graph;

  public DessineRectangleListener(DessinablesData dessinables, Dessin dessin) {
    this.dessinables = dessinables;
    this.dessin = dessin;
  }

  @Override
  public void mousePressed(MouseEvent e){
    x1 = x2 = e.getX();
    y1 = y2 = e.getY();
    this.graph = this.dessin.getGraphics();
    this.graph.setXORMode(this.dessin.getBackground());
  }

  @Override
  public void mouseDragged(MouseEvent e){
    int[] infoRect = getInfoRectangle();
    this.graph.drawRect(infoRect[0], infoRect[1], infoRect[2], infoRect[3]);
    this.x2 = e.getX();
    this.y2 = e.getY();
    infoRect = getInfoRectangle();
    this.graph.drawRect(infoRect[0], infoRect[1], infoRect[2], infoRect[3]);
  }

  @Override
  public void mouseReleased(MouseEvent e){
    int[] infoRect = getInfoRectangle();
    this.graph.drawRect(infoRect[0], infoRect[1], infoRect[2], infoRect[3]);
    Color coul = new Color(Utilitaires.getIntAlea_1_Max(256)-1, Utilitaires.getIntAlea_1_Max(256)-1, Utilitaires.getIntAlea_1_Max(256)-1);
    this.graph.setPaintMode();
    x2 = e.getX();
    y2 = e.getY();
    infoRect = getInfoRectangle();
    dessinables.addDessinable(new Rectangle(infoRect[0], infoRect[1], infoRect[2], infoRect[3], coul));
  }

  private int[] getInfoRectangle() {
    int xDeb = this.x1;
    int yDeb = this.y1;
    int xFin = this.x2;
    int yFin = this.y2;

    // System.out.println(x1 + " " + x2);

    if (x1 > x2) {
      xDeb = x2;
      xFin = x1;
    }

    if (y1 > y2) {
      yDeb = y2;
      yFin = y1;
    }

    int[] retour = {xDeb, yDeb, xFin-xDeb, yFin-yDeb};
    return retour;
  }


  // public void mouseClicked(MouseEvent e){
  //   int largeur = Utilitaires.getIntAlea_1_Max(MAX_LENGTH);
  //   int hauteur = Utilitaires.getIntAlea_1_Max(MAX_LENGTH);
  //   Color coul =  new Color(Utilitaires.getIntAlea_1_Max(256)-1, Utilitaires.getIntAlea_1_Max(256)-1, Utilitaires.getIntAlea_1_Max(256)-1);
  //   Rectangle r = new Rectangle(e.getX(), e.getY(), largeur, hauteur, coul);
  //   dessinables.addDessinable(r);
  // }
}
