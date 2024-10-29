# Informe Técnico: Configuración y Verificación del servicio DNS

<br><br>

## Indice
-  [Introducción](#introducción)
- [1. Verificación del paquete DNS](#1-verificación-del-paquete-dns)
  - [Comandos](#comandos)
  
- [2. Verificación del servicio DNS](#2-verificación-del-servicio-dns)
  - [Comandos](#comandos-1)
  
- [3. Verificación del puerto correcto](#3-verificación-del-puerto-correcto)
  - [Comandos](#comandos-2)
  
- [4. Verificación de consulta de nombres de dominio](#4-verificación-de-consulta-de-nombres-de-dominio)
  - [Comandos](#comandos-3)

- [5. Validación de registros DNS de la escuela de ciberseguridad](#5-validación-de-registros-dns-de-la-escuela-de-ciberseguridad)
  - [Comandos](#comandos-4)
  - [5.1. Verificar configuración DNS en el servidor](#5.1-verificar-configuración-dns-en-el-servidor)
  - [5.2. Reiniciar el servidor DNS](#5.2-reiniciar-el-servidor-dns)
  - [5.3. Confirmar conectividad del servidor de correo](#5.3confirmar-conectividad-del-servidor-de-correo)
  - [5.4. Diagnosticar registros A](#5.4-diagnosticar-registros-a)
  - [5.5. Revisar registros de errores](#revisar-registros-de-errores)

- [Conclusión](#conclusión)

<br>

# Introducción

En el siguiente informe, se explicarán en detalle los pasos necesarios para configurar y verificar el servicio DNS en un sistema operativo Linux. El objetivo es guiar a los usuarios a través de una serie de comandos y configuraciones relacionadas con el DNS, incluyendo la verificación de la configuración actual, la modificación de los servidores DNS, y la utilización de herramientas para diagnosticar y resolver problemas de resolución de nombres de dominio.


# 1. Verificación del paquete DNS
En este primer control, comprobaremos si el paquete DNS (bind9) está instalado en el sistema. Para realizar esta verificación, sigue estos pasos:

- **Actualizar el sistema e instalar** el servicio en el caso de que no esté en nuestro sistema.
- **Comprobar** el estado del servicio.
- **Iniciar** el servicio.
- **Introducir** contraseña de usuario.

### COMANDOS:
```bash
# Actualizamos e instalamos
sudo apt-get update
sudo apt-get install bind9
```
<br>

# 2. Verificación del servicio DNS
En este control, comprobaremos que el servicio DNS (bind9) esté en funcionamiento y habilitado para iniciar automáticamente al arrancar el sistema. Para realizar dicha comprobación usaremos los siguientes comandos:

```bash
# Iniciamos el servicio
service bind9 status
```

En el caso de que nos diga que se encuentra en estado apagado o sin iniciar, usamos los siguientes comandos:

```bash
# Iniciar el servicio si no está activo
service bind9 start

# Habilitar el servicio para que se inicie automáticamente al arrancar el sistema
systemctl enable bind9

# Verificar el estado del servicio
service bind9 status
```

Al verificar el estado, si el servicio está "activo (en ejecución)", el control es exitoso.

<br>

# 3. Verificación del puerto correcto
En este control comprobaremos que el servicio DNS (bind9) está escuchando en el puerto predeterminado, que en este caso es el 53. Para ello haremos lo siguiente:

*   **Comprobar** puertos en escucha.
    
*   **Activar** el puerto en caso de que no esté escuchando.

### COMANDOS:
```bash
# Comprobamos que el puerto 53 está en escucha usando el comando
ss -ltn | grep :53

# Si es necesario y no aparece el puerto 53, permitimos las conexiones en TCP y UDP
sudo ufw allow 53/tcp
sudo ufw allow 53/udp
```

Si al ejecutar el primer comando se muestra el puerto 53 en escucha, el control habrá sido exitoso, sino, con los comandos ejecutados ya debería realizarse correctamente.

<br>


# 4. Verificación de consulta de nombres de dominio

Este control verifica que el servidor DNS (bind9) pueda resolver nombres de dominio correctamente utilizando el comando dig.

### Pasos:

*   **Ejecutar** una consulta DNS para verificar la resolución de nombres de dominio.
    
### COMANDOS:

```bash
# Realizar una consulta DNS para verificar que el servidor resuelve nombres
dig @localhost example.com

# La salida debe mostrar una "ANSWER SECTION". Si es así, la consulta fue exitosa.
```

Si la salida muestra una sección "ANSWER SECTION" y el estado de salida es correcto *(exit_status = 0)*, el servidor DNS está resolviendo nombres de dominio correctamente, y el control será exitoso.

<br>

# 5. Validación de registros DNS de la escuela de ciberseguridad

En este control, verificaremos que los registros DNS específicos (A y MX) del dominio de la escuela de ciberseguridad estén configurados correctamente.

### Pasos:

*   **Comprobar** la existencia del registro A para el dominio.
*   **Comprobar** la existencia del registro MX para el dominio.
    
### COMANDOS:
```bash
# Verificar el registro A para el dominio de la escuela
dig @localhost -t A escuela-ciberseguridad.com

# Verificar el registro MX para el dominio de la escuela
dig @localhost -t MX escuela-ciberseguridad.com

# En ambos casos, debería aparecer una sección "ANSWER SECTION" en la salida.
```

Si ambos comandos muestran una "ANSWER SECTION" y el estado de salida es correcto (exit_status = 0), el control de los registros DNS específicos para la escuela de ciberseguridad será exitoso.

<br>

Si tanto el registro A como el registro MX no están funcionando correctamente, puede haber problemas en la configuración DNS, en la configuración del servidor o en la conectividad. Para comprobar dónde está el fallo, realizamos las siguientes comprobaciones.

## 5.1. Verificar configuración DNS en el servidor
*   Confirmar configuración de los registros DNS: Usamos dig para consultar ambos registros y asegurarnos de que están configurados correctamente:

```bash
dig @localhost -t A escuela-ciberseguridad.com
dig @localhost -t MX escuela-ciberseguridad.com
```

*   **Revisar zonas y archivos de configuración**: En servidores DNS como bind9, verifica que el archivo de zona del dominio (/etc/bind/zones/escuela-ciberseguridad.com.zone, por ejemplo) tenga los registros A y MX definidos correctamente y que el archivo esté sin errores de sintaxis.


## 5.2. Reiniciar el servidor DNS
*   Reiniciamos el servidor DNS para aplicar cambios o corregir problemas temporales:
```bash
sudo systemctl restart bind9
```

## 5.3. Confirmar conectividad del servidor de correo
*   **Verificamos el acceso al servidor de correo:** Intentamos conectar con el servidor de correo en el puerto SMTP (generalmente el puerto 25) para asegurarnos de que está accesible:
```bash
telnet mail.escuela-ciberseguridad.com 25
```

*   **Comprobar firewalls:** Tenemos que asegurarnos de que los puertos necesarios (como el puerto 53 para DNS y el 25 para correo) estén abiertos en el firewall del servidor y en cualquier firewall intermedio

## 5.4. Diagnosticar registros A
*   **Confirmar IP del registro A:** Nos tenemos  de que el registro A apunte a la IP correcta de tu servidor. Puedes hacerlo comprobando el archivo de zona en el servidor DNS o consultando:

```bash
dig @localhost -t A escuela-ciberseguridad.com
```

*   **Ping a la IP:** En el caso de tener una IP en el resgistro A, le intentamos hacer ping para comprobar la conexión:
```bash
ping <dirección_IP_del_servidor>
```

## 5.5. Revisar registros de errores
*   En servidores DNS como bind9, revisaremos los registros de errores en /var/log/syslog o en otros archivos de registro relacionados:

```bash
sudo tail -f /var/log/syslog
```

# Conclusión
A lo largo de este informe, se han detallado los pasos necesarios para asegurar que el servicio DNS (bind9) esté correctamente configurado y funcionando. Hemos verificado que el paquete esté instalado, que el servicio esté activo y habilitado para iniciarse automáticamente al arrancar el sistema, que esté escuchando en el puerto adecuado (53) para los protocolos TCP y UDP, y que pueda resolver nombres de dominio correctamente. Finalmente, hemos validado que los registros DNS específicos, como los registros A y MX para el dominio de la escuela de ciberseguridad, estén configurados adecuadamente para asegurar un servicio de resolución de nombres fiable y funcional.
