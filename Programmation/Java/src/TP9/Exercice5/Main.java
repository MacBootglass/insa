package TP9.Exercice5;

import javax.swing.*;
import java.awt.*;
import java.awt.event.*;

public class Main{

  public static void main(String args[]) {
    JFrame frame = new JFrame("Excercice 5");
    GestionListe g1 = new GestionListe();
    GestionListe g2 = new GestionListe();
    JButton g1ToG2 = new JButton(">");
    JButton g2ToG1 = new JButton("<");
    g1ToG2.addActionListener(new JButtonListener(g1, g2));
    g2ToG1.addActionListener(new JButtonListener(g2, g1));
    JPanel buttons = new JPanel(new GridLayout(5,1));
    buttons.add(new JPanel());
    buttons.add(g1ToG2);
    buttons.add(new JPanel());
    buttons.add(g2ToG1);
    buttons.add(new JPanel());
    frame.getContentPane().add(g1, BorderLayout.WEST);
    frame.getContentPane().add(buttons, BorderLayout.CENTER);
    frame.getContentPane().add(g2, BorderLayout.EAST);
    frame.pack();
    frame.setVisible(true);
  }

}
