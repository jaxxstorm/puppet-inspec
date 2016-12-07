# Manages to installation of inspec
class inspec::install {

  case $inspec::install_method {
    'url': {
      include ::archive

      file { $inspec::download_path :
        ensure => directory,
      } ->
      archive { "${inspec::download_path}${inspec::package_name}-${inspec::package_version}.${inspec::os_family}${inspec::os_ver}.${inspec::os_arch}.${inspec::package_suffix}" :
        ensure => present,
        source => $inspec::real_download_url,
      } ->
      package { 'inspec':
        ensure   => present,
        provider => 'rpm',
        source   => "${inspec::download_path}${inspec::package_name}-${inspec::package_version}.${inspec::os_family}${inspec::os_ver}.${inspec::os_arch}.${inspec::package_suffix}"
      }
    }
    'package': {
      package { $inspec::package_name :
        ensure => $inspec::package_version
      }
    }
    default: { fail("Unsupported installation method. Options are 'url' and 'package', you picked ${inspec::install_method}") }
  }

}
