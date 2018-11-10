# inspec facts

Facter.add('inspec_version') do
  setcode do
    Facter::Core::Execution.exec('/usr/bin/inspec version')
  end
end
