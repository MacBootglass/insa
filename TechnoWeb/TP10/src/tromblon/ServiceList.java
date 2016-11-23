package tromblon;

import java.util.*;
import java.io.*;

public class ServiceList implements Serializable{
  private List<Service> serviceList;

  public ServiceList() {
    this.serviceList = new ArrayList<Service>();
  }

  public List<Service> getServices() {
    return this.serviceList;
  }

  public void addService(Service service) {
    this.serviceList.add(service);
  }
}
