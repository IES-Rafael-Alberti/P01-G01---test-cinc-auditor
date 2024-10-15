# Test de auditoria sobre Open SSH

## Introducción

OpenSSH es una suite de herramientas que proporciona capacidades de conexión segura a través de la red. Esta documentación está diseñada para guiarte a través de la instalación y configuración de OpenSSH, asegurando que se cumplan los controles de seguridad necesarios.

Los controles de seguridad creados por mi compañero son:

  - Verificar la instalación de OpenSSH.
  - Verificar la instalación de OpenSSH.
  - Configurar el protocolo de SSH para que solo permita la versión 2.
  - Deshabilitar el inicio de sesión root a través de SSH.

En mi caso he virtualizado un servidor Ubuntu 22.04 para inslar los servicios.

## Paso 1: Actualizaremos el sistema

Antes de instalar OpenSSH es importante asegurarnos de que todos los paquetes del sistema estén actualizados, para ello usaremos los siguientes comandos:

```bash
sudo apt update
sudo apt upgrade -y
```

## Paso 2: Instalar OpenSSH

Para instalar OpenSSH Server en Ubuntu o Debian, utiliza el siguiente comando:

```bash
sudo apt install openssh-server -y
```

## Paso 3: Verificar la Instalación de OpenSSH

Después de la instalación, verifica que OpenSSH esté instalado correctamente. Usaremos el siguiente comando:

```bash
dpkg -l | grep openssh-server
```
Deberías ver una salida que confirme que el paquete está instalado. Este paso está cubierto por el control sshd-00.

## Paso 3: Configurar OpenSSH

Para editar la configuración accederemos al archivo ubicado normalmente en /etc/ssh/sshd_config.

# 1.- Verificar la versión de OpenSSH

Para asegurarnos de que utilizamos la última version de OpenSSH, utilizamos el siguiente comando:

```bash
ssh -V
```

Asegúrate de que la versión coincida con la especificada en los controles (en este caso, OpenSSH_9.6p1). Si no tienes la versión correcta, deberás actualizar el paquete.

# 2.- Configurar el protocolo SSH.

Deberemos asegurarnos de que el servidor esté configurado únicamente para usar la versión 2 del protocolo, para ello buscamos en la línea que dice _Protocol_ en el archivo de configuración y asegúrate de que esté configurada como:

__Protocol 2__

Si la línea está comentada asegúrate de eliminar el # y que esté correctamente configurado.

# 3.- Deshabilitar el inicion de sesión root.

Para una mejor seguridad, deshabilitaremos el inicio de sesión del root a través de SSH. Buscamos en la línea que dice _PermitRootLogin_ y asegúrate de que esté configurada de la siguiente manera:

__PermitRootLogin no__

Si no encuentras la línea añádela al archivo.

# 4.- Guardar y salir

Guardamos los cambios del archivo de configuración y reiniciaremos el servicio para que se apliquen los cambios

Para guardar en _nano_ pulsamos (ctrl+o) para guardar y luego (ctrl+x) para salir, para reiniciar el servicio usamos

```bash
sudo systemctl restart ssh
```

##Conclusión

En resumen, siguiendo estos requisitos previos, podrás instalar, configurar y auditar OpenSSH de forma segura y eficiente. Asegúrate de contar con acceso privilegiado, un sistema actualizado, claves SSH configuradas y herramientas como InSpec para la verificación.

