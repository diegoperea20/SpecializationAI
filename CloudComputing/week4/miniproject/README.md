# Nota a tener encuenta
En Vagrant, se recomienda que la dirección IP de la máquina virtual no termine en 0 o 1 porque son direcciones reservadas en la mayoría de las redes. En las redes, la dirección IP terminada en 0 es generalmente utilizada como dirección de red y la dirección IP terminada en 1 es utilizada como dirección de broadcast. Por lo tanto, para evitar posibles conflictos de red, se recomienda evitar el uso de estas direcciones IP al configurar la dirección IP de una máquina virtual en Vagrant.

En general, es una buena práctica evitar el uso de direcciones IP reservadas y en su lugar utilizar direcciones IP que se encuentren dentro del rango permitido de la red donde se está configurando la máquina virtual.

Sí tienes errores puedes eliminar la carpeta ".vagrant" que es donde se almacena info al crear maquinas