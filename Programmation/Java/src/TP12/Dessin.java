package TP12;

import javax.swing.*;
import java.awt.*;
import java.awt.event.*;
import java.util.*;

// TODO compléter la classe
public class Dessin extends JPanel implements Observer{
  private DessinablesData dessinables;

  public Dessin() {
    super();

    setOpaque(true);
    setBackground(Color.white);
    setPreferredSize(new Dimension(300,200));

  }

  // TODO associe les données à la zone de dessin et les déclare observables par Dessin
  public void setModel(DessinablesData dessinables) {
    this.dessinables = dessinables;
    this.dessinables.addObserver(this);
  }


  // TODO dessine le ou les figures contenues dans les données
  // si une figure est reçu ne dessiner que celle-ci
  // sinon tout redessiner
  public void update(Observable obs, Object o) {
    if(o == null)
      this.repaint();
    else
      ((Dessinable)o).dessine(this.getGraphics());
  }

  // TODO dessine les figures contenues dans les données
  public void paintComponent(Graphics gc) {
    super.paintComponent(gc);
    for (Iterator i = this.dessinables.iterator(); i.hasNext();)
      ((Dessinable)i.next()).dessine(gc);
  }

}
