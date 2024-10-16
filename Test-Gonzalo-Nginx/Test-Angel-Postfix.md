# Paso 1: Verificar que Postfix esté instalado y en ejecución
## Control:

```ruby
control 'postfix-service' do
  impact 1.0
  title 'Postfix está activo'
  desc 'Postfix debe estar instalado y en ejecución.'

  describe service('postfix') do
    it { should be_installed }
    it { should be_running }
  end
end
```


## Comandos:
1. Instalar Postfix:

```bash
sudo apt install postfix
```

2. Verificar si el servicio está activo:

```bash
systemctl status postfix
```
Debes asegurarte de que el servicio esté en estado active (running). Si no lo está, puedes iniciarlo con el siguiente comando:


```bash
sudo systemctl start postfix
```
3. Habilitar Postfix para que arranque automáticamente al iniciar el sistema:

```bash
sudo systemctl enable postfix
```

# Paso 2: Verificar que Postfix está escuchando en el puerto SMTP estándar (25)
## Control:
```ruby
control 'postfix-port-25' do
  impact 1.0
  title 'Postfix escucha en el puerto 25'
  desc 'Postfix debería estar escuchando en el puerto 25 (SMTP).'

  describe port(25) do
    it { should be_listening }
  end
end
```
## Comandos:

1. Verificar si Postfix está escuchando en el puerto 25:

```bash
sudo netstat -tuln | grep :25
```
O también:

```bash
sudo ss -tuln | grep :25
```

Si no está escuchando, asegúrate de que Postfix esté correctamente configurado. Puedes reiniciar el servicio para asegurarte de que los cambios en la configuración tomen efecto:

```bash
sudo systemctl restart postfix
```

# Paso 3: Verificar los permisos del archivo de configuración principal
## Control:

```ruby
control 'postfix-config-permissions' do
  impact 0.5
  title 'Permisos del archivo de configuración de Postfix'
  desc 'El archivo de configuración de Postfix debe ser propiedad de root y tener permisos correctos.'

  describe file('/etc/postfix/main.cf') do
    it { should be_owned_by 'root' }
    its('mode') { should cmp '0644' }
  end
end
```

## Comandos:
1. Verificar la propiedad del archivo /etc/postfix/main.cf:

```bash
ls -l /etc/postfix/main.cf
```
2. Asegurarse de que el archivo sea propiedad de root: Si no lo es, puedes cambiar el propietario con:

``` bash
sudo chown root:root /etc/postfix/main.cf
```

3. Verificar los permisos del archivo (deben ser 0644):

```bash
stat -c "%a" /etc/postfix/main.cf
```
4. Si los permisos no son correctos, puedes corregirlos con:

```bash
sudo chmod 644 /etc/postfix/main.cf
```

# Paso 4: Verificar la versión de Postfix
## Control:
```ruby
control 'postfix-version' do
  impact 0.7
  title 'Versión de Postfix'
  desc 'Comprobar que la versión de Postfix cumple con los requisitos.'

  describe command('postconf mail_version') do
    its('stdout') { should match /3.8.6/ }  # Cambia esto a la versión requerida
  end
end
```

## Comandos:
1. Verificar la versión actual de Postfix:

```bash
postconf mail_version
```

2. Si la versión no es la requerida (3.8.6 en este caso), considera actualizar Postfix:

En sistemas basados en Ubuntu/Debian:

```bash
sudo apt update
sudo apt install --only-upgrade postfix
```
En sistemas basados en RedHat/CentOS:

bash
sudo yum update postfix
