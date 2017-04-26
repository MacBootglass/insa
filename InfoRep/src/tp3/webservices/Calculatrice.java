package tp3.webservices;

import javax.jws.*;
import javax.jws.soap.*;
import javax.xml.ws.*;
import javax.swing.*;


@WebService(name="Calculatrice")
@SOAPBinding(style=SOAPBinding.Style.RPC)
public class Calculatrice {
  @WebMethod
  public int addition(int val1, int val2) {
    return val1 + val2;
  }

  @WebMethod
  public int soustraction(int val1, int val2) {
    return val1 - val2;
  }

  @WebMethod
  public int multiplication(int val1, int val2) {
    return val1 * val2;
  }

  @WebMethod
  public int division(int val1, int val2) {
    if (val1 != 0)
      return val1 / val2;
    return 0;
  }

  public static void main(String[] args) {
    String serveur = "localhost";
    int port = 8080;
    String serviceName = "calculatrice";
    Endpoint endpoint = Endpoint.publish("http://" + serveur + ":" + port + "/" + serviceName, new Calculatrice());
    JOptionPane.showMessageDialog(null, "Eteindre le serveur");
    endpoint.stop();
  }
}
