import java.time.LocalDateTime;
import java.io.Serializable;

public class Message implements Serializable{
  private String author;
  private String mail;
  private String date;
  private String message;

  public Message(String author, String mail, String message) {
    this.author = author;
    if (this.author == null)
      this.author = "";

    this.mail = mail;
    if (this.mail == null)
      this.mail = "";

    this.message = message;
    if (this.message == null)
      this.message = "";
    this.date = LocalDateTime.now().toString();
  }

  public String getAuthor() {
    return this.author;
  }

  public String getMail() {
    return this.mail;
  }

  public String getDate() {
    return this.date;
  }

  public String getMessage() {
    return this.message;
  }

  public String toString() {
    return  "<div class=\"message\">" +
              "<div class=\"info\">" +
                "<div class=\"author\">" +
                  this.getAuthor() +
                "</div>" +
                "<div class=\"mail\">" +
                  this.getMail() +
                "</div>" +
                "<div class=\"date\">" +
                  this.getDate() +
                "</div>" +
              "</div>" +
              "<div class=\"message\">" +
                this.getMessage() +
              "</div>" +
            "</div>";
  }
}
