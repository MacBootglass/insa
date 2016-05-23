package TP12;

import java.awt.*;

// **************************************
// class LeRectangle
// **************************************
public class Rectangle extends Figure {
  protected int x1,y1,x2,y2;         // coordonnees du LeRectangle

  // constructeur
  public Rectangle(int _x1, int _y1, int _x2, int _y2, Color _couleur) {
    super(_couleur);
    setLeRectangle(_x1, _y1, _x2, _y2);
  }

  public void setLeRectangle(int _x1, int _y1, int _x2, int _y2) {
    x1 = _x1;
    y1 = _y1;
    x2 = _x2;
    y2 = _y2;
  }

  public double getPerimetre() {
    return 2*(y2-y1)+2*(x2-x1);
  }

  public double getSurface() {
    return (y2-y1)*(x2-x1);
  }

  public String toString() {
    return super.toString()+" de type LeRectangle ("+x1+","+y1+","+x2+","+y2+")";
  }

  public void dessine(Graphics gc) {
    gc.setColor(getCouleur());
    gc.fillRect(x1, y1, x2, y2);
  }

}
