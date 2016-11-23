```
            Table     Chaine     Protocole    Action

iptables -t filter -I INPUT   -p imcp      -j DROP

                      OUTPUT     tcp          DENY

                      FORWARD    udp          ACCEPT

                                              LOG
```
```
$ iptables -t filter -I FORWARD -p tcp --dport 80 -s 10.1.1.1/32 -d 8.8.8.8/32 -j ACCEPT --comment "blablabla"
$ iptables -nvL
```

# Configurer default gateway
```
$ route add -net 0/0 gw 10.1.0.250
```

# Afficher la table de routage
```
$ route -n
$ netstat -rn
$ ip route show
```
