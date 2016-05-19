import java.sql.*;
import java.util.Scanner;

public class MainGestionDressing{

/* MAIN ------------------------------------------------------------------------- */
/* ------------------------------------------------------------------------------ */
   public static void main(String[] args)  throws Exception {
	  int choix; //pour le menu
	  GestionDressing gD;
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
  		System.out.println("6 - Sortir");
  		System.out.println("Quel Choix ?");
  		choix = sc.nextInt();
  		sc.nextLine();
		/* ------------------------------------------------------------------------------ */
			switch (choix) {
			/* Ajout dans la table CHAUSSURE -------------------------------------------------- */
			case 1 : // A COMPLETER
        gD.ajouter(11, 1, "Rouge", "Baskets");

			break;
			/* ------------------------------------------------------------------------------ */
			/* Supprimer dans la table CHAUSSURE ---------------------------------------------- */
			case 2 : // A COMPLETER


			break;
			/* ------------------------------------------------------------------------------ */
			/* Afficher tables -------------------------------------------------------------- */
			case 3 : // A COMPLETER


			break;
			/* ------------------------------------------------------------------------------ */
			/*  Fonctionnalité mettre un vêtement à laver ----------------------------------- */
			case 4 : // A COMPLETER

			break;
			/* ------------------------------------------------------------------------------ */
			/* Appel de la procédure stockée proportionVetementsPropres ----------------------*/
			case 5 : // A COMPLETER
			break;

			/* ------------------------------------------------------------------------------ */
			case 6 :
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
