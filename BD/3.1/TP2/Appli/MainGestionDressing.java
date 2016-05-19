import java.sql.*;
import java.util.Scanner;

public class MainGestionDressing{

/* MAIN ------------------------------------------------------------------------- */
/* ------------------------------------------------------------------------------ */
   public static void main(String[] args)  throws Exception {
	  int choix; //pour le menu
	  GestionDressing gD;
    int idDressing ;
    String couleur ;
    String type ;
    int idContenu ;
    String table ;
	   /* Connexion à la base ---------------------------------------------------------- */
    gD = new GestionDressing();

		System.out.println("------------- Connexion à la base effectuée -------------");
		/* ------------------------------------------------------------------------------ */

		/* MENU ------------------------------------------------------------------------- */
		Scanner sc = new Scanner(System.in);
		do{
  		System.out.println("1 - Ajouter un tuple dans la table CHAUSSURE");
  		System.out.println("2 - Supprimer un tuple dans la table CHAUSSURE");
  		System.out.println("3 - Afficher les tables");
  		System.out.println("4 - Mettre un vêtement à laver");
  		System.out.println("5 - Affiche la proportion de vêtements propre d'un dressing (appel procédure stockée)");
      System.out.println("6 - Afficher id vetements de saison");
  		System.out.println("7 - Sortir");
  		System.out.println("Quel Choix ?");
  		choix = sc.nextInt();
  		sc.nextLine();
		/* ------------------------------------------------------------------------------ */
			switch (choix) {
			/* Ajout dans la table CHAUSSURE -------------------------------------------------- */
			case 1 :
				System.out.println("Insertion dans CHAUSSURE : iddressing, couleur, typec ?");
				idDressing = sc.nextInt() ;
				sc.nextLine();
				couleur = sc.next() ;
				sc.nextLine();
				type = sc.next() ;
				sc.nextLine();
        gD.ajouter(idDressing, couleur , type);

			break;
			/* ------------------------------------------------------------------------------ */
			/* Supprimer dans la table CHAUSSURE ---------------------------------------------- */
			case 2 :
				System.out.println("Entrez l'id de la chaussure que vous voulez supprimer :");
				idContenu = sc.nextInt() ;
				sc.nextLine();
				gD.supprimer(idContenu) ;


			break;
			/* ------------------------------------------------------------------------------ */
			/* Afficher tables -------------------------------------------------------------- */
			case 3 :
        System.out.println(gD.afficherTables()) ;
				System.out.println("Entrez le nom de la table que vous voulez afficher :");
				table = sc.next() ;
				sc.nextLine();
				System.out.println(String.format("-------------Table %s-------------- ", table )) ;
				System.out.println(gD.afficher(table)) ;

			break;
			/* ------------------------------------------------------------------------------ */
			/*  Fonctionnalité mettre un vêtement à laver ----------------------------------- */
			case 4 :
        System.out.println(gD.afficher("dressing")) ;
        System.out.println("Entrez l'id du dressing :");
        idDressing = sc.nextInt() ;
        System.out.println(gD.afficheVetements(idDressing)) ;
        System.out.println("Quel vetement voulez vous mettre au lavage :") ;
        idContenu = sc.nextInt() ;
        gD.mettreAuSale(idContenu) ;

			break;
			/* ------------------------------------------------------------------------------ */
			/* Appel de la procédure stockée proportionVetementsPropres ----------------------*/
			case 5 :
        System.out.println("Pourcentage:");
        System.out.println(gD.proportionVetementPropre()) ;
			break;

			/* ------------------------------------------------------------------------------ */
      case 6 :
        System.out.println(gD.afficher("vetementSaisonEnCours"));
      break;

			case 7 :
        gD.deconnexion();
			break;

			default:
			   System.out.println("Choix non valide");
			}
		}while(choix != 6);


		/* Deconnexion de la base ------------------------------------------------------ */

		System.out.println("------------- Déconnexion de la base ------------");
		/* ------------------------------------------------------------------------------ */
    }
/* ------------------------------------------------------------------------------ */
}
