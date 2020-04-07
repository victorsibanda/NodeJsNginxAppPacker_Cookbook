# InSpec test for recipe NodeJSNginx::default

# The InSpec reference, with examples and extensive documentation, can be
# found at https://www.inspec.io/docs/reference/resources/



# Port 80 should be litsening its not
describe port(80) do
  it { should be_listening }
end

describe service('nginx') do
  it {should be_enabled}
  it {should be_running}
end

## This should be changed to 8.11
describe package('nodejs') do
  it {should be_installed}
  its('version') {should cmp > '/8\././\././\./'}
end


describe npm('pm2') do
  it {should be_installed}
end

describe npm('react') do
  it {should be_installed}
end

## This should be 500 not nil
describe http('http://localhost') do
  its('status') {should cmp 502}
end
