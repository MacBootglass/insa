import java.sql.*;
import java.util.Scanner;


/**
 *
 * @author gdelmondo
 */
 public class GestionDressing {

   private final static String LIGNE = "--------------------";
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
  public void ajouter(int idDressing, String couleur, String typeC) throws SQLException {
    requete = conn.prepareStatement("insert into chaussure(idDressing, couleur, typeC) values (?, ?, ?)");
    requete.setInt(1, idDressing);
    requete.setString(2, couleur);
    requete.setString(3, typeC);
    requete.executeUpdate();
    requete.close();
  }


  /* SUPPRIME CHAUSSURE ----------------------------------------------------------- */
  /* supprime une paire de chaussures de la table CHAUSSURE en fonction de l'idcontenu fourni*/
  public void supprimer(int idContenu) throws SQLException {
    requete = conn.prepareStatement("delete from chaussure where idContenu = ?");
    requete.setInt(1, idContenu);
    requete.executeUpdate();
    requete.close();
  }


  /* AFFICHE TABLES DE LA BASE ---------------------------------------------------- */
  /* affiche la liste des tables de la base, sans les tables systèmes ------------- */
  public String afficherTables() throws SQLException {
  	StringBuilder retour = new StringBuilder() ;
    requete = conn.prepareStatement("select tableName from pg_tables where tableOwner = 'grtt5'" );

    ResultSet table = requete.executeQuery();

  	while(table.next())
      retour.append(String.format("- %s \n",table.getString( 1)));

  	requete.close();

  	return retour.toString() ;

  }

  /* AFFICHE TABLE    ------------------------------------------------------------- */
  /* affiche la table dont le nom est passé en paramètre -------------------------- */
  /* ------------------------------------------------------------------------------ */
  public String afficher(String nomTable) throws SQLException {
  	StringBuilder retour = new StringBuilder() ;
    StringBuilder ligne = new StringBuilder();
    requete = conn.prepareStatement("select * from "+nomTable);

    ResultSet table = requete.executeQuery();

  	int nbColonnes = table.getMetaData().getColumnCount() ;
  	for(int i=1 ; i <= nbColonnes ; i++) {
  		retour.append(String.format("%20s", table.getMetaData().getColumnLabel(i))) ;
      ligne.append(LIGNE);
      if (i < nbColonnes) {
        retour.append("|") ;
        ligne.append("+");
      }
    }
  	retour.append(String.format("\n%s\n", ligne.toString())) ;
  	while(table.next()) {
  		for(int i=1 ; i <= nbColonnes ; i++){
  			retour.append(String.format("%-20s", table.getString(table.getMetaData().getColumnName(i)))) ;
        if (i < nbColonnes)
          retour.append("|") ;
      }
  		retour.append("\n") ;
    }
  	requete.close();
  	return retour.toString() ;
  }
  /* AFFICHE TABLE CHAUSSURE ------------------------------------------------------ */
  /* affiche la table CHAUSSURE --------------------------------------------------- */





  /* affiche les vêtements d'un dressing passé en paramètre,
  l'utilisateur choisi celui à mettre au sale ------------------------------------- */
  /* ------------------------------------------------------------------------------ */
  public String afficheVetements(int idDressing) throws SQLException {
    StringBuilder retour = new StringBuilder() ;
    requete = conn.prepareStatement("select * from VETEMENT where iddressing = ? and lavage = false");
    requete.setInt(1, idDressing) ;

    ResultSet table = requete.executeQuery();

  	int nbColonnes = table.getMetaData().getColumnCount() ;
  	for(int i=1 ; i <= nbColonnes ; i++){
  		retour.append( table.getMetaData().getColumnLabel(i)) ;
  		retour.append("|") ;
  	}
  	retour.append("\n") ;
  	while(table.next()){
  		for(int i=1 ; i <= nbColonnes ; i++){
  			retour.append( table.getString( table.getMetaData().getColumnName(i))) ;
  			retour.append("|") ;
  		}
  		retour.append("\n") ;
  	}
  	requete.close();
  	return retour.toString() ;
  }


  public void mettreAuSale(int idContenu) throws SQLException {
    StringBuilder retour = new StringBuilder() ;
    requete = conn.prepareStatement("update vetement set lavage = true where idContenu = ?");
    requete.setInt(1, idContenu) ;
    requete.executeUpdate();
  	requete.close();
  }

  /* ------------------------------------------------------------------------------ */

  /* PROPORTION VETEMENTS PROPRES ------------------------------------------------- */
  /* appel la procédure proportionVetementsPropres pour un dressing
  /* passé en paramètre ----------------------------------------------------------- */

  public double proportionVetementPropre() throws SQLException {
    double resultat ;
    CallableStatement st = conn.prepareCall("{? = call proportionVetementPropre()}") ;
    st.registerOutParameter(1, Types.FLOAT) ;
    st.execute() ;
    resultat = st.getDouble(1) ;
  	st.close();
    return resultat ;
  }
}
