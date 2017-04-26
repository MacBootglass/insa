package tp3.client;

public class Client {
  public static void main(String[] args) {
    Calculatrice calculatrice = new CalculatriceService().getCalculatricePort();
    System.out.println(calculatrice.soustraction(3, 8));
  }
}
