CLASSPATH=./src:$JBOSS_HOME/modules/javax/servlet/api/main/jboss-servlet-api_3.0_spec-1.0.0.Final.jar

javac -cp $CLASSPATH -sourcepath src -d ./WEB-INF/classes src/tromblon/*.java

jar cf Tromblon.war WEB-INF ressources accueil.jsp facture.jsp
cp Tromblon.war $JBOSS_HOME/standalone/deployments
