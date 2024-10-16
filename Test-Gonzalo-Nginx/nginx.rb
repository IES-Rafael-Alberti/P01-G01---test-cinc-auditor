# nginx_check.rb

control 'nginx-service' do
  impact 1.0
  title 'NGINX está activo y habilitado'
  desc 'NGINX debe estar corriendo y habilitado para iniciar al arrancar el sistema.'

  describe service('nginx') do
    it { should be_installed }
    it { should be_running }
    it { should be_enabled }
  end
end

control 'nginx-port' do
  impact 1.0
  title 'NGINX está escuchando en el puerto 80 (HTTP)'
  desc 'NGINX debería estar escuchando en el puerto 80 para recibir tráfico HTTP.'

  describe port(80) do
    it { should be_listening }
    its('protocols') { should include 'tcp' }
  end
end

control 'nginx-version' do
  impact 0.7
  title 'Comprobar la versión de NGINX'
  desc 'La versión de NGINX debe ser la especificada para cumplir con los requisitos de seguridad.'

  describe nginx do
    its('version') { should eq '1.24.0' }
  end
end

control 'nginx-owner-permissions' do
  impact 0.5
  title 'Comprobar que el archivo de configuración de NGINX tiene los permisos correctos'
  desc 'El archivo de configuración de NGINX debe ser propiedad del usuario root y tener permisos adecuados.'

  describe file('/etc/nginx/nginx.conf') do
    it { should be_owned_by 'root' }
    its('mode') { should cmp '0644' }
  end
end

