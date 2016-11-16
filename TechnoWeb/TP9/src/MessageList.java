import java.util.*;
import java.io.*;

public class MessageList implements Serializable {
  private List<Message> list;

  public MessageList() {
    list = new ArrayList<Message>();
  }

  public void addMessage(Message message) {
    list.add(message);
  }

  public String toString() {
    String retour = "<div class=\"messageList\">";
    for (int i=0; i<this.list.size(); i++) {
      retour += this.list.get(i);
    }
    return retour + "</div>";
  }
}
