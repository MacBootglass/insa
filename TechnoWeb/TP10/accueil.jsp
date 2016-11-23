<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page language="java" import="tromblon.*" %>

<!DOCTYPE html>
<html>
  <head>
    <title>Accueil</title>
    <link rel="stylesheet" href="/Tromblon/ressources/style/accueil.css">
  </head>
  <body>
    <form action="accueil.jsp" method="post">
      <fieldset>
        <legend>Ajout d'un nouveau service</legend>

        <div class="champ">
          <label for="email">E-Mail: </label>
          <input type="email" name="email" value="">
        </div>

        <div class="champ">
          <label for="name">Service proposé: </label>
          <input type="text" name="name" value="">
        </div>

        <div class="champ">
          <label for="value">Nombre de tromblons: </label>
          <input type="number" name="value" value="">
        </div>

        <textarea name="description" rows="8" cols="80" placeholder="Saisissez une description complète du service proposé"></textarea>

        <div class="champ">
          <input type="submit" name="" value="Envoyer">
        </div>
      </fieldset>
    </form>

    <a href="#">Lister les services reservés</a>

    <jsp:useBean id="service" class="tromblon.Service" scope="page">
      <jsp:setProperty name="service" property="*"/>
    </jsp:useBean>


    <jsp:useBean id="serviceList" class="tromblon.ServiceList" scope="page">
    </jsp:useBean>

    <%
      if (service != null)
        serviceList.addService(service);
      out.println(serviceList.getServices().size());
    %>

    <fieldset>
      <legend>Liste des services existants</legend>
      <table>
        <tbody>
          <%
          for (Service s : serviceList.getServices()) {
            %>
            <tr>
              <td>
                <%=s.getEmail()%>
              </td>
              <td>
                <%=s.getDate()%>
              </td>
            </tr>
            <tr>
              <td>
                <%=s.getName()%>: <%=s.getValue()%>
              </td>
              <td>
                <a href="#">Ajouter à la liste des services reservés</a>
              </td>
            </tr>
            <tr>
              <td colspan="2">
                <%=s.getDescription()%>
              </td>
            </tr>
            <%
            }
          %>
        </tbody>
      </table>
    </fieldset>
  </body>
</html>
