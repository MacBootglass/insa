package TP10.GUI;

import TP10.App.*;
import javax.swing.*;
import java.awt.*;
import java.awt.event.*;
import java.util.Observer;
import java.util.Observable;

public class ControleurVuePuissance4Graphique extends JPanel implements Observer, MouseListener{
  private Puissance4 p4;
  private JOptionPane popup;
  private int colonnes;
  private int lignes;
  private int hauteurPion;
  private int largeurPion;
  private int marge;


  public ControleurVuePuissance4Graphique(Puissance4 p4){
    super();
    this.p4 = p4;
    this.lignes = p4.getHauteur();
    this.colonnes = p4.getLargeur();
    this.marge = 5;
    this.hauteurPion = (int)(getHeight() / this.lignes) - this.marge;
    this.largeurPion = (int)(getWidth() / this.colonnes) - this.marge;
    this.setMinimumSize(new Dimension(200, 200));
    this.setPreferredSize(new Dimension(800, 800));
    this.addMouseListener(this);
    this.p4.addObserver(this);
  }

  public void paintComponent(Graphics g) {
    super.paintComponent(g);
    this.marge = 5;
    this.hauteurPion = (int)(getHeight() / this.lignes) - this.marge;
    this.largeurPion = (int)(getWidth() / this.colonnes) - this.marge;
    for (int i = 0; i < this.colonnes; i++)
      for (int j = 0; j < this.lignes ; j++) {
        g.setColor(Color.lightGray);
        switch (this.p4.getJeton(i,j)) {
          case VIDE:
            g.setColor(Color.lightGray);
            break;
          case ROUGE:
            g.setColor(Color.red);
            break;
          case JAUNE:
            g.setColor(Color.yellow);
            break;
        }
        g.fillOval(i*(largeurPion+5), getHeight() - (j+1)*(hauteurPion+5), largeurPion, hauteurPion);
      }
  }

  public void update(Observable o, Object ob) {
    this.repaint();
  }

  public void mouseEntered(MouseEvent e) {

  }

  public void mouseClicked(MouseEvent e) {
    int joueColonne = e.getX()/(this.largeurPion + this.marge);
    try{
      this.p4.joueColonne(joueColonne);
    }
    catch(Puissance4ColonneException eP) {
      popup.showInternalMessageDialog(this, String.format("La colonne %d est pleine.", joueColonne), "Attention", JOptionPane.WARNING_MESSAGE);
    }
  }

  public void mouseExited(MouseEvent e) {

  }

  public void mousePressed(MouseEvent e) {

  }

  public void mouseReleased(MouseEvent e) {

  }

  public static void main(String[] args) {
    Puissance4 p4 = new Puissance4(5,6);
    JFrame frame = new JFrame("Puissance 4");
    frame.setDefaultCloseOperation(WindowConstants.EXIT_ON_CLOSE);
    frame.setContentPane(new ControleurVuePuissance4Graphique(p4));
    frame.pack();
    frame.setVisible(true);
    try{
      p4.joueColonne(4);
      p4.joueColonne(4);
      p4.joueColonne(0);
    }
    catch (Puissance4ColonneException e) {

    }
  }
}
