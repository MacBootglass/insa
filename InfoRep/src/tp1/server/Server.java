package tp1.server;

import java.io.IOException;
import java.net.ServerSocket;

public class Server {
  public static void main(String args[]) {
    ServerSocket socketServer;
    Thread thread;
    try {
      socketServer = new ServerSocket(8000);
      thread = new Thread(new AcceptClient(socketServer));
      thread.start();
      System.out.println("Serveur en attente de connexion");
    }
    catch(IOException e) {
      e.printStackTrace();
    }
  }
}
