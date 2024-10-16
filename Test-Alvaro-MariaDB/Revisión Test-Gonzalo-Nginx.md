# Informe Técnico: Configuración y Verificación del servicio Nginx

<br><br>

## Indice
-  [Introducción](#introducción)
- [1. Verificación estado servicio Nginx](#1-verificación-estado-servicio-nginx)
  - [Comandos](#comandos)
  
- [2. Verificación puerto correcto](#2-verificación-puerto-correcto)
  - [Comandos](#comandos-1)
  
- [3. Verificación versión](#3-verificación-versión)
  - [Comandos](#comandos-2)
  
- [4. Verificación permisos archivo de configuración](#4-verificación-permisos-archivo-de-configuración)
  - [Comandos](#comandos-3)

- [Conclusión](#conclusión)

<br>

## Introducción
En el siguiente informe explicaré en detalle los pasos necesarios para poder utilizar correctamente el servicio Nginx. El objetivo es pasar una serie de test relacionados con el servicio Nginx, entre los que se encuentra comprobar si el servicio está activo o no, si está escuchando por el puerto concreto del servicio, etc.


## 1. Verificación estado servicio Nginx.
Este primer control comprueba el estado del servicio Nginx, en el caso de estar instalado, comprueba si está activo y funcionando correctamente. Debe iniciarse automáticamente al iniciarse el sistema. Para lograr hacer funcionar este control, realizaremos los siguientes pasos:

- **Actualizar el sistema e instalar** el servicio en el caso de que no esté en nuestro sistema.
- **Comprobar** el estado del servicio.
- **Iniciar** el servicio.
- **Introducir** contraseña de usuario.

### COMANDOS:
```bash
# Actualizamos e instalamos
sudo apt-get update
sudo apt-get install nginx

# Iniciamos el servicio
service nginx start

# Comprobamos el estado del servicio para ver que esté funcionando correctamente
service nginx status
```
Si ahora ejecutamos el control, nos debería decir que se ha realizado correctamente el primero de ellos, donde comprueba que está instalado y funcionando correctamente.

<br>

## 2. Verificación puerto correcto.
En este control comprobaremos que el servicio está escuchando por el puerto predeterminado del servicio, en este caso el 80. Para ello hacemos lo siguiente:

- **Comprobar** puertos en escucha.
- **Activar** puerto en el caso de no estar escuchando.

### COMANDOS:
```bash
# Comprobamos que el puerto está escuchando usando el comando
ss -ltn

# Si es necesario y no aparece el puerto 80 usamos
sudo ufw allow 80
```

<br>

## 3. Verificación versión.
En este tercer control lo que haremos será comprobar que la versión del servicio nginx sea la última disponible, en este caso es la 1.24.0. En el caso de que tengamos instalada dicha versión saldrá el test correcto. Si nos da error, significa que no tenemos el servicio actualizado.

### COMANDOS:
```bash
# Comprobamos la versión que tenemos
nginx -v

# Si nos dice que la versión es 1.24.0, el test será correcto, sino tendremos que actualizar con el comando
sudo apt-get upgrade nginx
```

<br>

## 4. Verificación permisos archivo de configuración.
En este último control comprobaremos si el fichero de configuración del servicio tiene los permisos necesarios. En este caso, el archivo debe ser propiedad del root y tener permisos adecuados.

### COMANDOS:
```bash
# Para comprobar a quién pertenece el archivo y que permisos tiene usamos los comando:
ls -l /etc/nginx/nginx.conf

stat -c "%a %U %G" /etc/nginx/nginx.conf


# Si nos da de resultado otro usuario que no sea root, usamos el siguiente comando para cambiar los permisos:
sudo chown root:root /etc/nginx/nginx.conf
```
<br>

## CONCLUSIÓN
A lo largo de este informe, hemos detallado los pasos necesarios para asegurar que el servicio Nginx está correctamente configurado y funcionando. Hemos verificado que el servicio esté instalado, activo y habilitado para arrancar automáticamente, que esté escuchando por el puerto adecuado, que la versión del servicio sea la más reciente y, por último, garantizando que los permisos del archivo de configuración sean los correctos.
