# Install and manage the inspec repo
class inspec::repo {

  case $::osfamily {
    'Debian': {
      include '::inspec::repo::apt'
    }
    'RedHat': {
      include '::inspec::repo::yum'
    }
    default: { fail('Unsupported OS') }
  }

}
