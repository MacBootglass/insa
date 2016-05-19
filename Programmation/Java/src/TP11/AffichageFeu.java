/*
 * AffichageFeu.java
 *
 * Created on 20 juin 2006, 17:11
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */

package TP11;

import java.awt.*;
import javax.swing.*;
import java.util.Observable;
import java.util.Observer;



/**
 *
 * @author nicolas
 */
public class AffichageFeu extends JPanel implements Observer{

    private Feu feu;
    private JLabel rouge;
    private JLabel orange;
    private JLabel vert;

    /** Creates a new instance of AffichageFeu */
    public AffichageFeu(Feu feu) {
      super(new GridLayout(3,1));
      this.feu = feu;
      this.feu.addObserver(this);
      this.rouge = new JLabel("O");
      this.orange = new JLabel("O");
      this.vert = new JLabel("O");
      this.setColor();
      this.add(rouge);
      this.add(orange);
      this.add(vert);
    }

    public void eteindre() {
      this.rouge.setForeground(Color.black);
      this.orange.setForeground(Color.black);
      this.vert.setForeground(Color.black);
    }

    public void setColor() {
      switch (this.feu.getEtat()) {
        case PASSE :
          this.vert.setForeground(Color.green);
          this.vert.repaint();
          break;
        case ATTENTION:
          this.orange.setForeground(Color.orange);
          this.orange.repaint();
          break;
        case ARRET:
          this.rouge.setForeground(Color.red);
          this.rouge.repaint();
          break;
      }
    }

    public void update(Observable o, Object ob) {
      this.eteindre();
      this.setColor();
    }

    public static void main(String[] arg) {
      Feu feu = new Feu(Feu.Etat.ARRET);
      JFrame frame1 = new JFrame("Feu Tricolore");
      frame1.setDefaultCloseOperation(WindowConstants.EXIT_ON_CLOSE);
      frame1.setContentPane(new AffichageFeu(feu));
      frame1.pack();
      frame1.setVisible(true);

      JFrame frame2 = new JFrame("Feu Tricolore");
      frame2.setDefaultCloseOperation(WindowConstants.EXIT_ON_CLOSE);
      frame2.setContentPane(new ControleurFeuGraphique(feu));
      frame2.pack();
      frame2.setVisible(true);
    }
}
