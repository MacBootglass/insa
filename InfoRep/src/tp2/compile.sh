javac serviceDeChiffrement/*.java

# Copiez dans rmiregistry/serviceDeChiffrement UNIQUEMENT les .class nécessaires

# Copiez dans Serveur/serviceDeChiffrement UNIQUEMENT les .class nécessaires

cd Serveur
javac Serveur.java
cd ..

# Copiez dans Client/serviceDeChiffrement UNIQUEMENT les .class nécessaires
cd Client
javac Client.java

