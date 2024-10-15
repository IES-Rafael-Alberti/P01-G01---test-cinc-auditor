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

control 'nginx-configuration' do
  impact 0.7
  title 'Verificar configuraciones básicas de seguridad de NGINX'
  desc 'El archivo de configuración principal de NGINX debe tener buenas prácticas de seguridad implementadas.'

  describe nginx_conf.params['http'] do
    it { should include 'server_tokens' => ['off'] }
  end

  describe nginx_conf.params['http'] do
    it { should include 'client_max_body_size' => ['1m'] }
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

