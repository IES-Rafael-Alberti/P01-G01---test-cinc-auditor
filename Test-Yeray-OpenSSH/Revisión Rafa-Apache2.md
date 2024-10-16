# Configuración y Verificación de Apache2 para pasar la auditorías de nuestro compañero

<br><br>

## Indice
-  [Introducción](#introducción)
- [1. Verificación del estado del servicio Apache2](#1-verificación-del-estado-del-servicio-apache2)
  - [Acciones necesarias](#acciones-necesarias)
  - [Comandos](#comandos)
  
- [2. Verificación del archivo de configuración principal de Apache2](#2-verificación-del-archivo-de-configuración-principal-de-apache2)
  - [Acciones necesarias](#acciones-necesarias-1)
  - [Comandos](#comandos-1)
  
- [3. Verificación de los puertos en los que Apache2 está escuchando](#3-verificación-de-los-puertos-en-los-que-apache2-está-escuchando)
  - [Acciones necesarias](#acciones-necesarias-2)
  - [Comandos](#comandos-2)
  
- [4. Verificación de los permisos de los archivos de logs de Apache2](#4-verificación-de-los-permisos-de-los-archivos-de-logs-de-apache2)
  - [Acciones necesarias](#acciones-necesarias-3)
  - [Comandos](#comandos-3)

- [Conclusión](#conclusión)

<br>

## Introducción:

En este informe detallaremos los pasos técnicos necesarios para asegurarnos que Apache2 esté correctamente configurado y cumpla con los requerimientos de una auditoría automatizada usando **cinc-auditor**. El objetivo es que Apache2 pase las verificaciones sobre el estado del servicio, configuración de archivos, puertos, permisos de logs y módulos habilitados.

Cada sección la hemos orientado a cumplir con un control específico de la auditoría.

<br>

## 1. Verificación del estado del servicio Apache2
**Control:** `apache2-status`  
**Impacto:** 1.0

Este control verifica que el servicio Apache2 esté correctamente instalado, habilitado y en ejecución. El servicio debe iniciarse automáticamente al arrancar el sistema y estar en ejecución de manera continua.

### Acciones necesarias:

1. **Instalar el servicio Apache2:** Si no está instalado, debemos proceder con su instalación utilizando el gestor de paquetes.
2. **Habilitar el servicio:** Apache2 debe configurarse para iniciarse automáticamente al arrancar el sistema.
3. **Iniciar el servicio:** Si el servicio no está activo, debemos iniciar manualmente.
4. **Verificar el estado:** Finalmente, verificaremos que Apache2 esté en ejecución.

### Comandos:

```bash
# Actualizar los repositorios e instalar Apache2
sudo apt-get update
sudo apt-get install apache2

# Habilitar el servicio Apache2
sudo systemctl enable apache2

# Iniciar el servicio si no está corriendo
sudo systemctl start apache2

# Verificar que Apache2 esté activo
sudo systemctl status apache2
```

<br>

## 2. Verificación del archivo de configuración principal de Apache2
**Control:** `apache2-config`  
**Impacto:** 0.8

Este control asegura que el archivo de configuración principal de Apache2, ubicado en `/etc/apache2/apache2.conf´`, exista y esté correctamente configurado en términos de permisos, propiedad y modo de archivo.

### Acciones necesarias:
1. **Comprobar la existencia del archivo:** El archivo debe estar presente en el sistema.
2. **Validar la propiedad y el grupo:** El archivo debe pertenecer al usuario y grupo root.
3. **Verificar los permisos:** El archivo debe tener los permisos 0644 para garantizar la seguridad adecuada.

### Comandos:

```bash
# Verificar la existencia y permisos del archivo de configuración
ls -l /etc/apache2/apache2.conf

# Si es necesario, establecer los permisos y propiedad correctos
sudo chown root:root /etc/apache2/apache2.conf
sudo chmod 0644 /etc/apache2/apache2.conf
```
<br>

## 3. Verificación de los puertos en los que Apache2 está escuchando
**Control:** `apache2-ports`
**Impacto:** 0.7

Este control garantiza que Apache2 esté escuchando en los puertos correctos, específicamente el puerto 80 para HTTP y el puerto 443 para HTTPS. Ambos puertos deben estar configurados y activos en el sistema.

### Acciones necesarias:
1. **Verificar configuración de puertos:** Los puertos 80 y 443 deben estar definidos en el archivo de configuración de puertos de Apache2.
2. **Habilitar SSL:** El puerto 443 requiere que el módulo SSL esté habilitado en Apache.
3. **Verificar que los puertos estén activos:** Debemos confirmar que Apache2 esté efectivamente escuchando en los puertos correspondientes.

### Comandos:

```bash
# Verificar que los puertos 80 y 443 estén configurados en Apache
sudo nano /etc/apache2/ports.conf

# Asegurarse de que las líneas siguientes estén presentes:
# Listen 80
# Listen 443

# Habilitar el módulo SSL necesario para el puerto 443
sudo a2enmod ssl
sudo systemctl restart apache2

# Verificar que Apache2 está escuchando en los puertos 80 y 443
sudo netstat -tuln | grep ':80\|:443'
```
<br>

## 4. Verificación de los permisos de los archivos de logs de Apache2
**Control:** `apache2-logs`
**Impacto:** 0.5

Este control se enfoca en los permisos y existencia de los archivos de logs principales de Apache2, access.log y error.log. Ambos archivos deben existir en el sistema y tener permisos restringidos para evitar accesos no autorizados.

### Acciones necesarias:
1. **Verificar la existencia de los logs:** Debemos confirmar que los archivos de log de acceso y error existen en el directorio /var/log/apache2/.
2. **Verificar los permisos:** Los archivos deben tener permisos 0640 para limitar el acceso de escritura solo al propietario.

### Comandos:

```bash
# Verificar la existencia de los archivos de log y sus permisos
ls -l /var/log/apache2/access.log /var/log/apache2/error.log

# Si los permisos no son los correctos, establecerlos manualmente
sudo chmod 0640 /var/log/apache2/access.log /var/log/apache2/error.log
```
<br>

## Conclusión:
En este informe proporcionamos una guía técnica y detallada para asegurar que el servidor Apache2 cumpla con los requisitos de auditoría establecidos por nuestro compañero. Al seguir los pasos descritos y ejecutar los comandos recomendados, garantizamos que Apache2 esté correctamente instalado, configurado y asegurado, cumpliendo con los controles críticos sobre su servicio, configuración, puertos, permisos 
de archivos de log y módulos habilitados.
