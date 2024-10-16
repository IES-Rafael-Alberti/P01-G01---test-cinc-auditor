control 'apache2-status' do
  impact 1.0
  title 'Verificar que el servicio Apache2 esté activo'
  desc 'El servicio Apache2 debe estar habilitado y corriendo'
  
  describe service('apache2') do
    it { should be_installed }
    it { should be_enabled }
    it { should be_running }
  end
end

control 'apache2-config' do
  impact 0.8
  title 'Verificar el archivo de configuración principal de Apache2'
  desc 'El archivo apache2.conf debe existir y debe tener los permisos correctos'
  
  describe file('/etc/apache2/apache2.conf') do
    it { should exist }
    it { should be_file }
    its('mode') { should cmp '0644' }  # Verifica los permisos del archivo
    its('owner') { should eq 'root' }
    its('group') { should eq 'root' }
  end
end

control 'apache2-ports' do
  impact 0.7
  title 'Verificar que Apache2 esté escuchando en el puerto correcto'
  desc 'Apache2 debe estar escuchando en el puerto 80 o 443 para HTTP/HTTPS'

  describe port(80) do
    it { should be_listening }
    its('protocols') { should include 'tcp' }
  end

  describe port(443) do
    it { should be_listening }
    its('protocols') { should include 'tcp' }
  end
end

control 'apache2-logs' do
  impact 0.5
  title 'Verificar los permisos de los archivos de logs de Apache'
  desc 'Los logs de Apache deben tener los permisos correctos y existir'

  describe file('/var/log/apache2/access.log') do
    it { should exist }
    it { should be_file }
    its('mode') { should cmp '0640' }  # Verifica permisos de lectura/escritura
  end

  describe file('/var/log/apache2/error.log') do
    it { should exist }
    it { should be_file }
    its('mode') { should cmp '0640' }  # Verifica permisos de lectura/escritura
  end
end

