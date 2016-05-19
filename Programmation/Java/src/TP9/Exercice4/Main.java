package TP9.Exercice4;

import javax.swing.*;
import java.awt.*;
import java.awt.event.*;

public class Main{

  public static void main(String args[]) {
    JFrame frame = new JFrame("Excercice 4");
    JTextFieldEffacable textField = new JTextFieldEffacable("Texte Initial", 20);
    JButton button = new JButton("Effacer");

    button.addActionListener(textField);
    frame.getContentPane().add(textField, BorderLayout.WEST);
    frame.getContentPane().add(button, BorderLayout.EAST);
    frame.pack();
    frame.setVisible(true);
  }

}
