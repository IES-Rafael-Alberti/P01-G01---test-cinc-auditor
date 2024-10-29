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


control 'mariadb-user-ciberschool' do
  impact 1.0
  title 'Debe existir un usuario específico para Ciber School'
  desc 'Verifica que exista un usuario en MariaDB llamado "ciberschool" para la gestión de la base de datos de la academia.'

  describe command('mysql -u root -e "SELECT User FROM mysql.user WHERE User=\'ciberschool\'"') do
    its('stdout') { should match /ciberschool/ }
    its('exit_status') { should eq 0 }
  end
end

control 'mariadb-database-ciberschool' do
  impact 1.0
  title 'La base de datos "ciberschool_db" debe existir'
  desc 'Asegura que existe una base de datos específica llamada "ciberschool_db" para almacenar datos de Ciber School.'

  describe command('mysql -u root -e "SHOW DATABASES LIKE \'ciberschool_db\'"') do
    its('stdout') { should match /ciberschool_db/ }
    its('exit_status') { should eq 0 }
  end
end

control 'mariadb-table-students-ciberschool' do
  impact 1.0
  title 'La tabla "students" debe existir en la base de datos ciberschool_db'
  desc 'Verifica que existe una tabla de estudiantes en ciberschool_db para registrar la información de los estudiantes.'

  describe command('mysql -u root -e "USE ciberschool_db; SHOW TABLES LIKE \'students\'"') do
    its('stdout') { should match /students/ }
    its('exit_status') { should eq 0 }
  end
end

control 'mariadb-table-courses-ciberschool' do
  impact 1.0
  title 'La tabla "courses" debe existir en la base de datos ciberschool_db'
  desc 'Asegura que haya una tabla "courses" para gestionar los cursos especializados de ciberseguridad.'

  describe command('mysql -u root -e "USE ciberschool_db; SHOW TABLES LIKE \'courses\'"') do
    its('stdout') { should match /courses/ }
    its('exit_status') { should eq 0 }
  end
end

control 'mariadb-table-labs-ciberschool' do
  impact 1.0
  title 'La tabla "labs" debe existir en la base de datos ciberschool_db'
  desc 'Verifica que existe una tabla "labs" para gestionar los laboratorios de práctica de ciberseguridad en ciberschool_db.'

  describe command('mysql -u root -e "USE ciberschool_db; SHOW TABLES LIKE \'labs\'"') do
    its('stdout') { should match /labs/ }
    its('exit_status') { should eq 0 }
  end
end

