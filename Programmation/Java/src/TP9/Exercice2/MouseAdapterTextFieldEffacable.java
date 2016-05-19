package TP9.Exercice2;

import javax.swing.*;
import java.awt.*;
import java.awt.event.*;

public class MouseAdapterTextFieldEffacable extends MouseAdapter {
  public void mouseClicked(MouseEvent e) {
    if (e.getSource() instanceof JTextField)
      ((JTextField)e.getSource()).setText("");
  }
}
