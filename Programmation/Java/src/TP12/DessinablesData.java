package TP12;

import java.util.*;

public class DessinablesData extends Observable {
  private LinkedList<Dessinable> dessinables = new LinkedList<Dessinable>();

  public void addDessinable(Dessinable d) {
    dessinables.add(d);
    setChanged();
    notifyObservers(d);

  }

  public void vider() {
    dessinables.clear();
    setChanged();
    notifyObservers();

  }

  public Iterator<Dessinable> iterator() {
    return dessinables.iterator();
  }


}
