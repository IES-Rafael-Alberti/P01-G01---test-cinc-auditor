# Verificar que Postfix está instalado y corriendo
control 'postfix-service' do
  impact 1.0
  title 'Postfix está activo'
  desc 'Postfix debe estar instalado y en ejecución.'

  describe service('postfix') do
    it { should be_installed }
    it { should be_running }
  end
end

# Verificar que Postfix está escuchando en el puerto SMTP estándar (25)
control 'postfix-port-25' do
  impact 1.0
  title 'Postfix escucha en el puerto 25'
  desc 'Postfix debería estar escuchando en el puerto 25 (SMTP).'

  describe port(25) do
    it { should be_listening }
  end
end

# Verificar que el archivo de configuración principal tiene los permisos correctos
control 'postfix-config-permissions' do
  impact 0.5
  title 'Permisos del archivo de configuración de Postfix'
  desc 'El archivo de configuración de Postfix debe ser propiedad de root y tener permisos correctos.'

  describe file('/etc/postfix/main.cf') do
    it { should be_owned_by 'root' }
    its('mode') { should cmp '0644' }
  end
end

# Verificar la versión de Postfix
control 'postfix-version' do
  impact 0.7
  title 'Versión de Postfix'
  desc 'Comprobar que la versión de Postfix cumple con los requisitos.'

  describe command('postconf mail_version') do
    its('stdout') { should match /3.8.6/ }  # Cambia esto a la versión requerida
  end
end

