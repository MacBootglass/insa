package tp1.client;

import java.io.*;
import java.net.*;
import java.util.*;

public class Client {
  public static void main(String args[]) {
    Socket socket;
    BufferedReader in;
    PrintWriter out;
    String messageIn;
    String messageOut;
    Scanner keyboard;


    try {
      socket = new Socket(InetAddress.getLocalHost(), 8000);
      out = new PrintWriter(socket.getOutputStream());
      keyboard= new Scanner(System.in);

      System.out.println("Veuillez saisir votre calcul: ");
      messageOut = keyboard.nextLine();
      out.println(messageOut);
      out.flush();

      in = new BufferedReader(new InputStreamReader(socket.getInputStream()));
      messageIn = in.readLine();
      System.out.println(messageIn);

      socket.close();
    }
    catch(Exception e) {
      e.printStackTrace();
    }
  }
}
