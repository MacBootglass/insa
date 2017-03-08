package tp2.serveur;

import java.rmi.Remote;
import java.rmi.RemoteException;
import tp2.service_de_chiffrement.*;

public interface IChiffrement extends Remote{
  public int chiffrerEntier(int val) throws RemoteException;

  public Document chiffrerDocument(Document doc) throws RemoteException;

  public void chiffrerFichier(Fichier fic) throws RemoteException;
}
