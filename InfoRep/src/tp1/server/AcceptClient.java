package tp1.server;

import java.io.*;
import java.net.*;
import javax.script.*;
import java.util.*;

public class AcceptClient implements Runnable {
  private ServerSocket socketServer;
  private Socket socket;

  public AcceptClient(ServerSocket socketServer) {
    this.socketServer = socketServer;
  }

  public void run() {
    PrintWriter out;
    BufferedReader in;
    String message;

    try {
      while (true) {
        this.socket = socketServer.accept();
        in = new BufferedReader(new InputStreamReader(this.socket.getInputStream()));
        out = new PrintWriter(this.socket.getOutputStream());

        message = in.readLine();
        out.println(message + " = " + eval(message));
        out.flush();
        this.socket.close();
      }
    }
    catch(IOException e) {
      e.printStackTrace();
    }
  }

  private int eval2(String calcul) {
    // calcul = calcul.replaceAll(" ", "");
    // System.out.println(calcul.matches("^[0-9]+[\+\*][0-9]+$"));

    // int leftOperande = sc.nextInt();
    // String operator = sc.next(Pattern.compile("[+-*/]"));
    // int rightOperande = sc.nextInt();

    // System.out.println(leftOperande + " " + operator + " " + rightOperande);
    return 0;
  }

  private String eval(String calcul) {
    try {
      ScriptEngineManager manager = new ScriptEngineManager();
      ScriptEngine engine = manager.getEngineByName("js");
      return engine.eval(calcul).toString();
    }
    catch(Exception e) {
      e.printStackTrace();
    }
    return "NaN";
  }
}
