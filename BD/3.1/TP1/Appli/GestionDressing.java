import java.sql.*;
import java.util.Scanner;


/**
 *
 * @author gdelmondo
 */
 public class GestionDressing {
	 private Connection conn;
   private PreparedStatement requete;
    /**
     * @param args the command line arguments
     */

/* CONNEXION ---------------------------------------------------------------------*/
/* ------------------------------------------------------------------------------ */
 public GestionDressing() throws ClassNotFoundException, SQLException{
   Class.forName("org.postgresql.Driver");
   conn = DriverManager.getConnection("jdbc:postgresql://asi-pg.insa-rouen.fr:5432/grtt5", "grtt5", "grtt5");
 }
/* ------------------------------------------------------------------------------ */

/* DECONNEXION -------------------------------------------------------------------*/
/* ------------------------------------------------------------------------------ */
public void deconnexion() throws SQLException{
  conn.close();
}


/* AJOUTE CHAUSSURE ------------------------------------------------------------- */
/* ajoute un tuple (idcontenu, iddressing, couleur, typec) dans la table CHAUSSURE*/
/* ------------------------------------------------------------------------------ */
public void ajouter(int idContenu, int idDressing, String couleur, String typeC) throws SQLException {
  requete = conn.prepareStatement("insert into chaussure values (?, ?, ?, ?)");
  requete.setInt(1, idContenu);
  requete.setInt(2, idDressing);
  requete.setString(3, couleur);
  requete.setString(4, typeC);
  requete.executeUpdate();
  requete.close();
}



/* ------------------------------------------------------------------------------ */

/* SUPPRIME CHAUSSURE ----------------------------------------------------------- */
/* supprime une paire de chaussures de la table CHAUSSURE en fonction de l'idcontenu fourni*/
/* ------------------------------------------------------------------------------ */

// A COMPLETER

/* ------------------------------------------------------------------------------ */

/* AFFICHE TABLES DE LA BASE ---------------------------------------------------- */
/* affiche la liste des tables de la base, sans les tables systèmes ------------- */
/* ------------------------------------------------------------------------------ */

// A COMPLETER

/* ------------------------------------------------------------------------------ */

/* AFFICHE TABLE CHAUSSURE ------------------------------------------------------ */
/* affiche la table CHAUSSURE --------------------------------------------------- */
/* ------------------------------------------------------------------------------ */

// A COMPLETER

/* ------------------------------------------------------------------------------ */

/* AFFICHE TABLE    ------------------------------------------------------------- */
/* affiche la table dont le nom est passé en paramètre -------------------------- */
/* ------------------------------------------------------------------------------ */

// A COMPLETER

/* ------------------------------------------------------------------------------ */

/* affiche les vêtements d'un dressing passé en paramètre,
l'utilisateur choisi celui à mettre au sale ------------------------------------- */
/* ------------------------------------------------------------------------------ */

// A COMPLETER

/* ------------------------------------------------------------------------------ */

/* PROPORTION VETEMENTS PROPRES ------------------------------------------------- */
/* appel la procédure proportionVetementsPropres pour un dressing
/* passé en paramètre ----------------------------------------------------------- */
/* ------------------------------------------------------------------------------ */

// A COMPLETER

/* ------------------------------------------------------------------------------ */







}
