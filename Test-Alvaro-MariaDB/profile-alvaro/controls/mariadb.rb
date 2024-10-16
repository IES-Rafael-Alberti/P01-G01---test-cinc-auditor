# mariadb_check.rb

control 'mariadb-package' do
  impact 1.0
  title 'MariaDB debe estar instalado'
  desc 'Se verifica que el paquete mariadb-server esté correctamente instalado en el sistema.'

  describe package('mariadb-server') do
    it { should be_installed }
  end
end

control 'mariadb-service' do
  impact 1.0
  title 'El servicio MariaDB debe estar corriendo y habilitado'
  desc 'Se comprueba que el servicio MariaDB esté en ejecución y habilitado para iniciar al arrancar el sistema.'

  describe service('mariadb') do
    it { should be_running }
    it { should be_enabled }
  end
end

control 'mariadb-port' do
  impact 1.0
  title 'El puerto 3306 de MariaDB debe estar en escucha'
  desc 'Se verifica que el puerto predeterminado de MariaDB (3306) esté escuchando para recibir conexiones.'

  describe port(3306) do
    it { should be_listening }
  end
end

control 'mariadb-root-connection' do
  impact 1.0
  title 'Debe ser posible conectarse a MariaDB como root'
  desc 'Se comprueba que la conexión al servidor MariaDB como usuario root sea exitosa.'

  describe command('mysql -u root -e "SELECT 1"') do
    its('exit_status') { should eq 0 }
  end
end
