javac -classpath ./classes -sourcepath ./src -d ./classes ./src/tp3/webservices/*.java
bash ./exec.sh tp3.webservices.Calculatrice &
sleep 1
rm -rf ./classes/tp3/client
cd classes
# wsgen -cp . tp3.webservices.Calculatrice -wsdl
wsimport -p tp3.client -keep http://127.0.0.1:8080/calculatrice?wsdl
cd ..
javac -classpath ./classes -sourcepath ./src -d ./classes ./src/tp3/client/*.java
bash ./exec.sh tp3.client.Client
