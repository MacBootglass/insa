package TP9.Exercice1;

import javax.swing.*;
import java.awt.*;

public class Main{
  public static void main(String args[]) {
    JFrame frame = new JFrame("Excercice 1");
    frame.getContentPane().add(new JTextFieldEffacable("Texte Initial", 20), BorderLayout.CENTER);
    frame.pack();
    frame.setVisible(true);
  }

}
