# Compte rendu de T
## I Serveur Web Apache HTTP

1. null
2. ```
    $   ssh ttheologien@asi-technoweb.insa-rouen.fr
   ```
3. ```
   $ chmod o+x /home/ttheologien
   $ chmod 755 /home/ttheologien/public_html
   $ scp -r TechnoWeb/ ttheologien@asi-technoweb.insa-rouen.fr:public_html
   ```
## II Protocole Http

1. null
  - ```
$ netcat asi-technoweb.insa-rouen.fr 80
GET /~ttheologien/index.html HTTP/1.1
Host: asi-technoweb.insa-rouen.fr
If-Modified-Since: Wed, 12 Oct 2016 12:36:54 GMT
  ```
  - ```
$ netcat asi-technoweb.insa-rouen.fr 80
GET /~ttheologien/index.html HTTP/1.1
Host: asi-technoweb.insa-rouen.fr
If-Unmodified-Since: Wed, 12 Oct 2016 12:36:54 GMT
  ```
2. ```
$ netcat asi-technoweb.insa-rouen.fr 80
GET /~ttheologien/index.html HTTP/1.1
Host: asi-technoweb.insa-rouen.fr
Range: bytes=2-5
    ```

3. ```
$ netcat asi-technoweb.insa-rouen.fr 80
GET /~ttheologien/TechnoWeb/TP4/images/logo-asi HTTP/1.1
Host: asi-technoweb.insa-rouen.fr
Accept: image/jpeg; q=1, image/png; q=0.5
    ```

4. ```
$ netcat asi-technoweb.insa-rouen.fr 80
GET /~ttheologien/fichier.txt HTTP/1.1
Host: asi-technoweb.insa-rouen.fr
Accept-Language: fr;q=1,en;q=0.7
  ```
netcat theologien-mo.com 80
GET /index.html HTTP/1.1
Host: theologien-mo.com
