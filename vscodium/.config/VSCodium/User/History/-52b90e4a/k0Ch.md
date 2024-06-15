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
dirección de red: 192.168.1.0

Segunda red de 60 hosts

Tercera red de 24 hosts

Cuarta red de 10 hosts
