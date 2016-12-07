# Private Params Class
class inspec::params {


  # Global params
  $package_name = 'inspec'
  $package_version = '1.7.1-1'
  $install_method = 'url'
  $download_url_base = 'https://packages.chef.io/stable/'
  $download_url = undef
  $download_path = '/tmp/'

  case $::architecture {
    'x86_64', 'amd64': {
      $os_arch = 'x86_64'
    }
    default: { fail('Unsupported OS Arch - inspec package only works on x86_64 hardware') }
  }

  case $::osfamily {
    'RedHat': {
      $os_family = 'el'
      $os_ver = $::operatingsystemmajrelease
      $package_suffix = 'rpm'
    }
    default: { fail('Unsupported OS') }
  }


}
