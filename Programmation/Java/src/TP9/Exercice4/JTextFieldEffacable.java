package TP9.Exercice4;

import javax.swing.*;
import java.awt.*;
import java.awt.event.*;


public class JTextFieldEffacable extends JTextField implements ActionListener{
  public JTextFieldEffacable(String text, int taille) {
    super(text, taille);
  }

  public void actionPerformed(ActionEvent e) {
    this.setText("");
  }
}
