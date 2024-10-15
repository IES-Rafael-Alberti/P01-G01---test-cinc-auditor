describe command('mysql -u root -e "SELECT 1"') do
  its('exit_status') { should eq 0 }
end