package tp2.service_de_chiffrement;

import java.io.*;

public class Fichier implements Serializable{
   private String nomDuFichier;

   public Fichier() {
      this.nomDuFichier = "";
   }

   public Fichier(String nom) {
      this.nomDuFichier = nom;
   }

   public String getContenu() {
      String contenu = "";
      try{
	 BufferedReader br = new BufferedReader(new InputStreamReader(new FileInputStream(this.nomDuFichier)));
	 while (br.ready()) {
	    contenu += br.readLine() + "\n";
	 }
	 br.close();
      } catch(IOException ioe){ ioe.printStackTrace(); }
      return contenu;
   }

   public void setContenu(String nouveauContenu) {
      try {
	 BufferedWriter output=new BufferedWriter(new FileWriter(this.nomDuFichier,false));
	 output.write(nouveauContenu);
	 output.flush();
	 output.close();
      } catch(IOException ioe){ ioe.printStackTrace(); }
   }
}
