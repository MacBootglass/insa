package tp2.serveur;

import java.rmi.registry.LocateRegistry;
import java.rmi.registry.Registry;
import java.rmi.server.UnicastRemoteObject;

import tp2.service_de_chiffrement.*;

public class Serveur {
  public static void main(String[] args) {
    try {
      int port = 1099;
      IChiffrement chiff = (IChiffrement) UnicastRemoteObject.exportObject(new Chiffrement(), 0);
      System.out.println("Serveur prêt");

      Registry registry = LocateRegistry.getRegistry(port);
      System.out.println("Service de registre détecté");

      registry.rebind("Chiffrement", chiff);
    }
    catch(Exception e) {
      e.printStackTrace();
    }
  }
}
