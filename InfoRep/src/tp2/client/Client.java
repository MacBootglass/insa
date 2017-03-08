package tp2.client;

import java.rmi.registry.LocateRegistry;
import java.rmi.registry.Registry;

import tp2.service_de_chiffrement.*;
import tp2.serveur.*;

public class Client {
  public static void main(String[] args) {
    String host = "localhost";
    int port = 1099;
    try {
      Registry registry = LocateRegistry.getRegistry(host, port);
      IChiffrement chiff = (IChiffrement) registry.lookup("Chiffrement");
      System.out.println("Service de chiffrement détécté");

      int val = 41;
      System.out.println("Valeur avant chiffrement: " + val);
      val = chiff.chiffrerEntier(val);
      System.out.println("Valeur après chiffrement: " + val);

      Document doc = new Document();
      System.out.println("Document avant chiffrement: " + doc.getContenu());
      doc = chiff.chiffrerDocument(doc);
      System.out.println("Document après chiffrement: " + doc.getContenu());

      Fichier fic = new Fichier("/home/ttheologien/Desktop/depot/insa/InfoRep/fichier.txt");
      System.out.println("Fichier avant chiffrement: " + fic.getContenu());
      chiff.chiffrerFichier(fic);
      System.out.println("Fichier après chiffrement: " + fic.getContenu());
    }
    catch(Exception e) {
      e.printStackTrace();
    }
  }
}
