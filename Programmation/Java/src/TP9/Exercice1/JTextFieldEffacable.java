package TP9.Exercice1;

import javax.swing.*;
import java.awt.*;
import java.awt.event.*;

public class JTextFieldEffacable extends JTextField implements MouseListener{

  public JTextFieldEffacable(String texte, int taille) {
    super(texte, taille);
    this.addMouseListener(this);
  }

  public void mouseClicked(MouseEvent e) {
    this.setText("");
  }

  public void mouseEntered(MouseEvent e) {}

  public void mouseExited(MouseEvent e) {}

  public void mousePressed(MouseEvent e) {}

  public void mouseReleased(MouseEvent e) {}
}
