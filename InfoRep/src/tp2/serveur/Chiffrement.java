package tp2.serveur;

import java.rmi.Remote;
import java.rmi.RemoteException;
import tp2.service_de_chiffrement.*;

public class Chiffrement implements IChiffrement{
  public Chiffrement() {
    super();
  }

  public int chiffrerEntier(int val) throws RemoteException {
    return val + 1;
  }

  public Document chiffrerDocument(Document doc) throws RemoteException {
    Document retour = new Document();
    retour.setContenu(doc.getContenu() + " c'est chiffré");
    return retour;
  }

  public void chiffrerFichier(Fichier fic) throws RemoteException {
    fic.setContenu(fic.getContenu() + " c'est chiffré");
  }
}
