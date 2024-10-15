describe file('etcmy.cnf') do
  it { should exist }
  its('content') { should match server-id = 1 }
end