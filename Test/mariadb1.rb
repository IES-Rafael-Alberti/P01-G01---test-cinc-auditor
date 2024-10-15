describe service('mariadb') do
  it { should be_running }
  it { should be_enabled }
end