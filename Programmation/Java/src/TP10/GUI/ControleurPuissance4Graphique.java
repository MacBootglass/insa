package TP10.GUI;

import TP10.App.*;
import javax.swing.*;
import java.awt.*;
import java.awt.event.*;
import java.util.Observer;
import java.util.Observable;

public class ControleurPuissance4Graphique extends JFrame implements ActionListener{
  private Puissance4 p4;
  private JTextField saisie;
  private JOptionPane popup;

  public ControleurPuissance4Graphique(Puissance4 p4) {
    super("Controleur Graphique");
    this.setDefaultCloseOperation(WindowConstants.EXIT_ON_CLOSE);
    this.p4 = p4;
    this.saisie = new JTextField(3);
    this.getContentPane().add(new JLabel("Colonne:"), BorderLayout.WEST);
    this.getContentPane().add(this.saisie, BorderLayout.EAST);
    this.saisie.addActionListener(this);
    this.pack();
    this.setVisible(true);
  }

  public void actionPerformed(ActionEvent e) {
    try {
      this.p4.joueColonne(Integer.parseInt(this.saisie.getText()));
    }
    catch(NumberFormatException eN) {
      popup.showMessageDialog(this, "Veuillez saisir un entier valide.", "Attention", JOptionPane.WARNING_MESSAGE);
    }
    catch(Puissance4ColonneException eP) {
      popup.showMessageDialog(this, "La colonne saisie est invalide.", "Attention", JOptionPane.WARNING_MESSAGE);
    }
    this.saisie.setText("");
  }

  public static void main(String[] args) {
    new ControleurPuissance4Graphique(new Puissance4(5,6));
  }

}
