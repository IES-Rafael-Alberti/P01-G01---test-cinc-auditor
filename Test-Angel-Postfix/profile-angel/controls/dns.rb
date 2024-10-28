# dns_check.rb

control 'dns-package' do
  impact 1.0
  title 'DNS debe estar instalado'
  desc 'Se verifica que el paquete de DNS (ej. bind9) esté correctamente instalado en el sistema.'

  describe package('bind9') do
    it { should be_installed }
  end
end

control 'dns-service' do
  impact 1.0
  title 'El servicio DNS debe estar corriendo y habilitado'
  desc 'Se comprueba que el servicio DNS esté en ejecución y habilitado para iniciar al arrancar el sistema.'

  describe service('bind9') do
    it { should be_running }
    it { should be_enabled }
  end
end

control 'dns-port' do
  impact 1.0
  title 'El puerto 53 de DNS debe estar en escucha'
  desc 'Se verifica que el puerto predeterminado de DNS (53) esté escuchando para recibir conexiones.'

  describe port(53) do
    it { should be_listening }
    its('protocols') { should include 'udp' }
    its('protocols') { should include 'tcp' }
  end
end

control 'dns-dig-lookup' do
  impact 1.0
  title 'La consulta de nombres de dominio debería funcionar correctamente'
  desc 'Se comprueba que el servidor DNS pueda resolver nombres de dominio usando la herramienta dig.'

  describe command('dig @localhost example.com') do
    its('stdout') { should match /ANSWER SECTION/ }
    its('exit_status') { should eq 0 }
  end
end

# Control adicional para validar registros DNS específicos de la escuela de ciberseguridad
control 'dns-school-records' do
  impact 1.0
  title 'Validación de registros DNS de la escuela de ciberseguridad'
  desc 'Se comprueba que los registros A y MX para el dominio de la escuela estén configurados correctamente.'

  describe command('dig @localhost -t A escuela-ciberseguridad.com') do
    its('stdout') { should match /ANSWER SECTION/ }
    its('exit_status') { should eq 0 }
  end

  describe command('dig @localhost -t MX escuela-ciberseguridad.com') do
    its('stdout') { should match /ANSWER SECTION/ }
    its('exit_status') { should eq 0 }
  end
end
