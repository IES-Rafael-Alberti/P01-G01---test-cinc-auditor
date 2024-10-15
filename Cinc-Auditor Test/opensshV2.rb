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
    desc 'Asegurar que se está utilizando la última versión estable de OpenSSH'
    
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