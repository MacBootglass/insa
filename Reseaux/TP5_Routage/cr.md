# TP 5: Routage

## Partie 1

- __PC 1__
```
PC1> ip 192.168.1.2/24 192.168.1.1
PC1> save PC1
```

- __PC 2__
```
PC2> ip 192.168.2.2/24 192.168.2.1
PC2> save PC2
```

- __Routeur 1__
```
R1# configure terminal
R1(config)# interface FastEthernet 0/0
R1(config-if)# ip address 192.168.1.1 255.255.255.0
R1(config-if)# no shutdown
R1(config-if)# exit
R1(config)# interface GigabitEthernet 1/0
R1(config-if)# ip address 100.0.0.1 255.0.0.0
R1(config-if)# no shutdown
R1(config-if)# exit
R1(config)# exit
R1# show ip interface brief
```
_sauvegarde de la configuration:_
```
R1# copy running-config startup-config
```
_routage statique:_
```
R1# configure terminal
R1(config)# ip route 192.168.2.0 255.255.255.0 100.0.0.2
R1(config)# exit
R1# show ip route
```
_routage dynamique:_
```
R1# configure terminal
R1(config)# no ip route *
R1(config)# router rip
R1(config-router)# redistributed connected
R1(config-router)# network 100.0.0.0
R1(config-router)# timers basic 5 15 15 20
R1(config-router)# version 2
```
_sauvegarde de la configuration:_
```
R1# copy running-config startup-config
```

- __Routeur 2__
```
R2# configure terminal
R2(config)# interface FastEthernet 0/0
R2(config-if)# ip address 192.168.2.1 255.255.255.0
R2(config-if)# no shutdown
R2(config-if)# exit
R2(config)# interface GigabitEthernet 1/0
R2(config-if)# ip address 100.0.0.2 255.0.0.0
R2(config-if)# no shutdown
R2(config-if)# exit
R2(config)# exit
R2# show ip interface brief
```
_sauvegarde de la configuration:_
```
R2# copy running-config startup-config
```
_routage statique:_
```
R2# configure terminal
R2(config)# ip route 192.168.1.0 255.255.255.0 100.0.0.1
```
_routage dynamique:_
```
R2(config)# no ip route *
R2(config)# router rip
R2(config-router)# redistributed connected
R2(config-router)# network 100.0.0.0
R2(config-router)# timers basic 5 15 15 20
R2(config-router)# version 2
```
_sauvegarde de la configuration:_
```
R1# copy running-config startup-config
```

## Partie 2
- __PC1__
```
PC1> load PC1
```

- __PC2__
```
PC1> load PC2
```

- __Routeur 1__
```
R1# configure terminal
R1(config)# interface FastEthernet 2/0
R1(config-if)# ip address 101.0.0.1 255.0.0.0
R1(config-if)# no shutdown
R1(config-if)# exit
R1(config)# exit
R1# copy running-config startup-config
```

- __Routeur 2__
```
R2# configure terminal
R2(config)# interface FastEthernet 2/1
R2(config-if)# ip address 102.0.0.2 255.0.0.0
R2(config-if)# no shutdown
R2(config-if)# exit
R2(config)# exit
R2# copy running-config startup-config
```

- __Routeur 3__
```
R3# configure terminal
R3(config)# interface FastEthernet 2/0
R3(config-if)# ip address 101.0.0.3 255.0.0.0
R3(config-if)# no shutdown
R3(config-if)# exit
R3(config)# interface FastEthernet 2/1
R3(config-if)# ip address 102.0.0.3 255.0.0.0
R3(config-if)# no shutdown
R3(config-if)# exit
R3(config)# router rip
R3(config-router)# redistributed connected
R3(config-router)# network 101.0.0.0
R3(config-router)# network 102.0.0.0
R3(config-router)# timers basic 5 15 15 20
R3(config-router)# version 2
R3(config-router)# exit
R3(config)# exit
R3# copy running-config startup-config
```
