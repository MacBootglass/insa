import java.io.*;
import java.util.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.util.Locale;

import java.nio.file.*;

public class Messagerie extends HttpServlet {
  public void doGet(HttpServletRequest requete, HttpServletResponse reponse) throws ServletException, IOException {
    PrintWriter out = reponse.getWriter();
    MessageList messageList;
    File file = new File("./messageList.obj");
    if (file.exists()) {
      try {
         FileInputStream fileIn = new FileInputStream(file);
         ObjectInputStream in = new ObjectInputStream(fileIn);
         messageList = (MessageList)in.readObject();
         in.close();
         fileIn.close();
      }
      catch(Exception e) {return;}
    }
    else {
      messageList = new MessageList();
    }
    messageList.addMessage(new Message(requete.getParameter("author"), requete.getParameter("mail"), requete.getParameter("message")));

    try {
         FileOutputStream fileOut = new FileOutputStream(file);
         ObjectOutputStream oOut = new ObjectOutputStream(fileOut);
         oOut.writeObject(messageList);
         oOut.close();
         fileOut.close();
      }
      catch(Exception e) {}

    reponse.setContentType("text/html; charset=UTF-8");
    reponse.setLocale(new Locale(Locale.FRENCH.getLanguage(), Locale.FRANCE.getCountry()));
    requete.setCharacterEncoding("UTF-8");

    requete.getRequestDispatcher("/ressources/html/header.html").include(requete, reponse);
    out.println("<body>");
    requete.getRequestDispatcher("/ressources/html/body.html").include(requete, reponse);
    out.println(messageList.toString());
    requete.getRequestDispatcher("/ressources/html/footer.html").include(requete, reponse);
    out.println("</body>");
  }
}
