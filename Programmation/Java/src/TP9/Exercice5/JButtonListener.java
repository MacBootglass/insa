package TP9.Exercice5;

import javax.swing.*;
import java.awt.*;
import java.awt.event.*;

public class JButtonListener implements ActionListener{
  private GestionListe g1;
  private GestionListe g2;
  public JButtonListener(GestionListe g1, GestionListe g2) {
    this.g1 = g1;
    this.g2 = g2;
  }

  public void actionPerformed(ActionEvent e) {
    g2.addElement(g1.removeSelection());
  }
}
