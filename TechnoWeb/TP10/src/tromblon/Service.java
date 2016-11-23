package tromblon;

import java.util.*;
import java.text.*;

import java.io.*;

public class Service implements Serializable{
  private static int nbServices = 0;
  private String email;
  private String name;
  private int value;
  private String description;
  private int id;
  private String date;

  public Service() {
    this.email = "";
    this.name = "";
    this.value = 0;
    this.description = "";
    this.id = ++this.nbServices;
    Date tmp = new Date();
    tmp.setTime(System.currentTimeMillis());
    this.date = (new SimpleDateFormat("E d MMM yyyy, H:m:s", Locale.FRANCE).format(tmp));
  }

  public void setEmail(String email) {
    this.email = email;
  }
  public void setName(String name) {
    this.name = name;
  }
  public void setValue(int value) {
    this.value = value;
  }
  public void setDescription(String description) {
    this.description = description;
  }

  public String getEmail() {
    return this.email;
  }
  public String getName() {
    return this.name;
  }
  public int getValue() {
    return this.value;
  }
  public String getDescription() {
    return this.description;
  }
  public int getId() {
    return this.id;
  }
  public String getDate() {
    return this.date;
  }
}
