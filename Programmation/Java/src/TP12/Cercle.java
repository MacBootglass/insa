package TP12;

import java.awt.*;

// **************************************
// class Cercle
// **************************************
public class Cercle extends Figure {
  protected int x,y;         // coordonnees du centre
  protected int rayon;

  // constructeur
  public Cercle(int _x, int _y, int _rayon, Color _couleur) {
    super(_couleur);
    setCercle(_x, _y, _rayon);
  }

  public void setCercle(int _x, int _y, int _rayon) {
    x     = _x;
    y     = _y;
    rayon = _rayon;
  }

  public double getPerimetre() {
    return 2*Math.PI*rayon;
  }

  public double getSurface() {
    return Math.PI*Math.pow(rayon,2);
  }

  public String toString() {
    return super.toString()+" de type Cercle ("+x+","+y+","+rayon+")";
  }

  public void dessine(Graphics gc) {
    gc.setColor(getCouleur());
    gc.fillOval(x, y, rayon, rayon);
  }
}
