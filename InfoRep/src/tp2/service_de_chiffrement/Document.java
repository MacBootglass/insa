package tp2.service_de_chiffrement;

import java.io.*;

public class Document implements Serializable{
   private String contenu;

   public Document(){
      this.contenu = "Contenu non defini";
   }

   public Document(String nouveauContenu){
      this.contenu = nouveauContenu;
   }

   public String getContenu(){
      return this.contenu;
   }

   public void setContenu(String nouveauContenu){
      this.contenu = nouveauContenu;
   }

   public String toString() {
      return this.contenu;
   }
}
