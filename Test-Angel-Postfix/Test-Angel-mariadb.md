# Test de Auditoría sobre Mariadb

## Introducción
MariaDB es un sistema de gestión de bases de datos de código abierto que se utiliza para almacenar, organizar y recuperar datos de manera eficiente.
Esta documentación está diseñada para guiarte a través de la instalación y configuración de MariaDB, asegurando que se cumplan los controles de seguridad necesarios.

## 1. Verificación Servicio
  - Verificar la instalación de MariaDB.
  - Asegurar la instalación inicial.
  - Configurar el servicio para que solo acepte conexiones locales.
  - Habilitar la autenticación segura mediante contraseñas.

### COMANDOS:
```bash
# Actualizamos el sistema e instalamos
sudo apt-get update
sudo apt install mariadb-server -y
```
## 2. Verificación Estado
# Iniciamos el proceso
service mariadb-server start

# Comprobamos el estado del servicio para ver si funciona correctamente
service mariadb-server status
```
 



