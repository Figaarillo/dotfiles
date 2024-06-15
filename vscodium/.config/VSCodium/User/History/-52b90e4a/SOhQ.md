# Direccioón IP: 192.168.1.0/24

- IP: privada
- Red: 192.168.1.0
- Broadcast: 192.168.1.255
- Hosts: 256

## Subneting

Crear una read para alojar los siguientes host: 60, 120, 10,24

/24 (128-2) => red de 120

/24 =>  /25 (64-2) => para la red de 60
        /25 (64-2) => /26 para la red de 24
                      /26 para la red de 10

Primera red de 120 hosts

- dirección de red: 192.168.1.0
- hosts disponibles: 192.168.1.1 - 192.168.1.126
- dirección de broadcast: 192.168.1.127

Segunda red de 60 hosts

- direccón de red: 192.168.1.128
- hosts: 192.168.1.1 - 192.168.1.190

Tercera red de 24 hosts

- direccón de red: 192.168.1.192
- hosts: 192.168.1.1 - 192.168.1.

Cuarta red de 10 hosts

- direccón de red: 192.168.1.224
- hosts: 192.168.1.1 - 192.168.1.
