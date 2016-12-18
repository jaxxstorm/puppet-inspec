# Manages to installation of inspec
class inspec::install {

  case $inspec::install_method {
    'package': {
      if $inspec::manage_repo {
        class { '::inspec::repo': }
      }
      package { $inspec::package_name :
        ensure => $inspec::package_version
      }
    }
    'gem': {
      package { $inspec::package_name :
        ensure   => $inspec::package_version,
        provider => 'gem'
      }
    }
    default: { fail("Unsupported installation method. Options are 'gem' and 'package', you picked ${inspec::install_method}") }
  }

}
