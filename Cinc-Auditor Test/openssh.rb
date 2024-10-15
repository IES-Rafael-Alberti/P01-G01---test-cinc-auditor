control 'sshd-01' do
    impact 1.0
    title 'Verificar versión de OpenSSH'
    desc 'Asegurar que se está utilizando la última versión estable de OpenSSH'
    
    describe command('ssh -V') do
      its('stderr') { should match /OpenSSH_9.6p1/ }
    end
  end
  
  control 'sshd-02' do
    impact 1.0
    title 'Configurar protocolo versión 2'
    desc 'Sólo deben permitirse conexiones de protocolo SSH versión 2'
    describe sshd_config do
      its('Protocol') { should cmp 2 }
    end
  end
  
  control 'sshd-03' do
    impact 1.0
    title 'Desactivar el inicio de sesión root'
    desc 'Desactivar el inicio de sesión root a través de SSH'
    describe sshd_config do
      its('PermitRootLogin') { should eq 'no' }
    end
  end