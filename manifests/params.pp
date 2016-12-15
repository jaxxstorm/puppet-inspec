# Private Params Class
class inspec::params {


  # Global params
  $package_name = 'inspec'
  $package_version = '1.7.1-1'
  $download_url_base = 'https://packages.chef.io/stable/'
  $download_url = undef
  $download_path = '/tmp/'
  $repo_channel = 'stable'
  $package_url_base = 'https://packages.chef.io/repos/'

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
      $manage_repo = true
      $package_url_type = 'yum'
      $install_method = 'package'
    }
    'Debian': {
      $manage_repo = true
      $package_url_type = 'apt'
      $install_method = 'package'
    }
    default: { fail('Unsupported OS') }
  }


}
