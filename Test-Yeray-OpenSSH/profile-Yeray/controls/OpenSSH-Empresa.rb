control 'sshd-00' do
    impact 1.0
    title 'Verificar instalación de OpenSSH'
    desc 'Asegurar que OpenSSH está instalado en el sistema'
    
    describe package('openssh-server') do
      it { should be_installed }
    end
  end
  
  control 'sshd-01' do
    impact 1.0
    title 'Verificar versión de OpenSSH'
    desc 'Asegurar que se está utilizando la  versión OpenSSH_9.6p1 de OpenSSH'
    
    only_if('OpenSSH está instalado') do
      package('openssh-server').installed?
    end
    
    describe command('ssh -V') do
      its('stderr') { should match /OpenSSH_9.6p1/ }
    end
  end
  
  control 'sshd-02' do
    impact 1.0
    title 'Configurar protocolo versión 2'
    desc 'Solo se deben permitir las conexiones del protocolo SSH versión 2'
    
    only_if('OpenSSH está instalado') do
      package('openssh-server').installed?
    end
    
    describe sshd_config do
      its('Protocol') { should cmp 2 }
    end
  end
  
  control 'sshd-03' do
    impact 1.0
    title 'Desabilitar conexiones root'
    desc 'Desabilitar las conexiones root en SSH'
    
    only_if('OpenSSH está instalado') do
      package('openssh-server').installed?
    end
    
    describe sshd_config do
      its('PermitRootLogin') { should eq 'no' }
    end
  end

control 'sshd-04' do
  impact 1.0
  title 'Verificar algoritmos de cifrado seguros'
  desc 'Asegurar que se utilizan algoritmos de cifrado seguros para SSH'
  
  describe sshd_config do
    its('Ciphers') { should match(/aes128-cbc,aes256-cbc/) }
  end
end

control 'sshd-05' do
  impact 1.0
  title 'Verificar tiempo de inactividad'
  desc 'Asegurar que se ha configurado un tiempo de inactividad para las sesiones SSH'
  
  describe sshd_config do
    its('ClientAliveInterval') { should cmp <= 300 }
    its('ClientAliveCountMax') { should cmp <= 3 }
  end
end

control 'sshd-06' do
  impact 1.0
  title 'Verificar desactivación de autenticación por contraseña'
  desc 'Asegurar que la autenticación por contraseña está desactivada en favor de claves SSH'
  
  describe sshd_config do
    its('PasswordAuthentication') { should eq 'no' }
  end
end

control 'sshd-07' do
  impact 1.0
  title 'Verificar tamaño mínimo de clave RSA'
  desc 'Asegurar que se utiliza un tamaño mínimo de clave RSA de 2048 bits'
  
  describe command('ssh -Q key') do
    its('stdout') { should match /ssh-rsa 2048/ }
  end
end
