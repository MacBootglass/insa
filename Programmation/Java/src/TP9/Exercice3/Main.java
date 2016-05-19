package TP9.Exercice3;

import javax.swing.*;
import java.awt.*;
import java.awt.event.*;

public class Main{

  public static void main(String args[]) {
    int dim = 1;
    JFrame frame;
    JTextField textField;
    MouseListener m = new MouseAdapterTextFieldEffacable();

    if (args.length >= 1) {
      if (Integer.parseInt(args[0]) > 0)
        dim = Integer.parseInt(args[0]);
      frame = new JFrame("Excercice 3");
      frame.setLayout(new GridLayout(dim,1));
      for (int i = 0; i < dim; i++) {
        textField = new JTextField("Texte Initial", 20);
        textField.addMouseListener(m);
        frame.getContentPane().add(textField);
      }
      frame.pack();
      frame.setVisible(true);
    }
  }

}
