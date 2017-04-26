package annuaire;

public class Personne {
  private String nom, bureau;

  public Personne() {}

  public Personne(String name, String office) {
  	this.nom = name;
  	this.bureau = office;
  }

  public String getNom() {
    return this.nom;
  }

  public void setNom(String name) {
    this.nom = name;
  }

  public String getBureau() {
    return this.bureau;
  }

  public void setBureau(String office) {
    this.bureau = office;
  }

  public String toString() {
    return this.nom + " : " + this.bureau;
  }
}
