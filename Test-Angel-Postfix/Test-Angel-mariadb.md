# Test de Auditoría sobre Mariadb

## Introducción
MariaDB es un sistema de gestión de bases de datos de código abierto que se utiliza para almacenar, organizar y recuperar datos de manera eficiente.
Esta documentación está diseñada para guiarte a través de la instalación y configuración de MariaDB, asegurando que se cumplan los controles de seguridad necesarios.

## Paso 1. Actualizar el sistema.

Antes de proceder con la instalación, es recomendable asegurarte de que tu sistema esté actualizado. Ejecuta los siguientes comandos en la terminal:

```
sudo apt update
sudo apt upgrade -y
```
## Paso 2. Instalar MariaDB
Para instalar el servidor de MariaDB, utiliza el siguiente comando:

```
sudo apt install mariadb-server -y
```
## Paso 3. Comprobar el Estado del Servicio MariaDB
Asegúrate de que el servicio de MariaDB esté en ejecución y habilitado para iniciar al arrancar el sistema. Puedes verificar el estado del servicio con el siguiente comando:

```
sudo systemctl status mariadb
```
Si el servicio no está en ejecución, puedes iniciarlo y habilitarlo con los siguientes comandos:

```
sudo systemctl start mariadb
sudo systemctl enable mariadb
```

## Paso 4. Probar la conexión a MariaDB
Para verificar que puedes conectarte a MariaDB como usuario root, ejecuta el siguiente comando:

```
mysql -u root -p
```
Introduce la contraseña que estableciste durante la ejecución de mysql_secure_installation. Deberías poder acceder al cliente de MariaDB.

Puedes realizar una consulta simple para comprobar que la conexión es exitosa:
```
SELECT 1;
```
## Paso 5. Comprobar el Puerto de Escucha

En el siguiente paso comprobaremos que el servicio está escuchando por el puerto predeterminado del servicio, en este caso el 3306. Para ello hacemos lo siguiente:

```
# Comprobamos que el puerto está escuchando usando el comando
ss -ltn

# Si es necesario y no aparece el puerto 3306 usamos
sudo ufw allow 3306
```

# Conclusión
En nuestra guía, hemos abordado los pasos necesarios para asegurar que la instalación del servicio MariaDB esté correctamente configurada y funcionando de manera óptima. Verificamos que el servicio esté instalado y habilitado para iniciar automáticamente, que esté escuchando en el puerto adecuado y que esté utilizando la versión más reciente. Además, nos aseguramos de que los permisos del archivo de configuración sean los correctos. Estas medidas son fundamentales para mantener un entorno de base de datos seguro y eficiente, garantizando la integridad y disponibilidad de los datos.


