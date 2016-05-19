package TP9.Exercice2;

import javax.swing.*;
import java.awt.*;
import java.awt.event.*;

public class Main{

  public static void methode1(){
    JFrame frame = new JFrame("Excercice 2");
    JTextField textField = new JTextField("Texte Initial", 20);
    textField.addMouseListener(new MouseAdapterTextFieldEffacable());
    frame.getContentPane().add(textField, BorderLayout.CENTER);
    frame.pack();
    frame.setVisible(true);
  }

  public static void methode2(){
    JFrame frame = new JFrame("Excercice 2");
    JTextField textField = new JTextField("Texte Initial", 20);
    textField.addMouseListener(new MouseAdapter(){
      public void mouseClicked(MouseEvent e) {
        if (e.getSource() instanceof JTextField)
          ((JTextField)e.getSource()).setText("");
      }
    });
    frame.getContentPane().add(textField, BorderLayout.CENTER);
    frame.pack();
    frame.setVisible(true);
  }

  public static void main(String args[]) {
    if (args.length >= 1)
      if (args[0].equals("1"))
        methode1();
      else
        methode2();
  }

}
