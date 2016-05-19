/*
 * ControleurFeuGraphique.java
 *
 * Created on 20 juin 2006, 23:29
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */

package TP11;

import java.awt.*;
import javax.swing.*;
import java.awt.event.*;
/**
 *
 * @author nicolas
 */
public class ControleurFeuGraphique extends JPanel implements ActionListener{
  private Feu feu;
  private JButton bRouge;
  private JButton bOrange;
  private JButton bVert;
  private JCheckBox cAuto;
  private ControleurFeuAuto auto;


  /** Creates a new instance of ControleurFeuGraphique */
  public ControleurFeuGraphique(Feu feu) {
    super(new GridLayout(1,4));
    this.feu = feu;

    this.bRouge = new JButton("Rouge");
    this.bOrange = new JButton("Orange");
    this.bVert = new JButton("Vert");
    this.cAuto = new JCheckBox("Automatique");

    this.bRouge.addActionListener(this);
    this.bOrange.addActionListener(this);
    this.bVert.addActionListener(this);
    this.cAuto.addActionListener(this);

    this.add(bRouge);
    this.add(bOrange);
    this.add(bVert);
    this.add(cAuto);
  }

  public void actionPerformed(ActionEvent e) {
    Object source = e.getSource();
    if (source.equals(this.bRouge))
      this.feu.setEtat(Feu.Etat.ARRET);
    else if (source.equals(this.bOrange))
      this.feu.setEtat(Feu.Etat.ATTENTION);
    else if (source.equals(this.bVert))
      this.feu.setEtat(Feu.Etat.PASSE);
    else if (source.equals(this.cAuto))
      if (this.cAuto.isSelected()) {
        this.auto = new ControleurFeuAuto(this.feu, 1000, 500, 500);
        this.bRouge.setEnabled(false);
        this.bOrange.setEnabled(false);
        this.bVert.setEnabled(false);
        (new Thread(this.auto, "controleur")).start();
      }
      else {
        this.auto.stop();
        this.bRouge.setEnabled(true);
        this.bOrange.setEnabled(true);
        this.bVert.setEnabled(true);
      }
  }

  public static void main(String[] args) {
    Feu feu = new Feu(Feu.Etat.ARRET);
    JFrame frame = new JFrame("Feu Tricolore");
    frame.setDefaultCloseOperation(WindowConstants.EXIT_ON_CLOSE);
    frame.setContentPane(new ControleurFeuGraphique(feu));
    frame.pack();
    frame.setVisible(true);
  }
}
