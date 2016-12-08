# Configure directories for inspec
class inspec::configure {

  file { $inspec::config_dir :
    ensure => directory,
  } ->
  file { "${inspec::config_dir}/${inspec::profiles_dir}" :
    ensure  => directory,
    purge   => $inspec::purge,
    recurse => $inspec::purge,
  } ->
  file { "${inspec::config_dir}/${inspec::downloads_dir}" :
    ensure  => directory,
    purge   => $inspec::purge,
    recurse => $inspec::purge,
  }

}
