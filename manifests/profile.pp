# Define: inspec::profiles
# Download an inspec profile and place it
# in an appropriate directory
#
# @example Download an inspec profile
#   ::inspec::profile { 'compliance':
#     source => 'http://my_url/compliance.tar.gz'
#   }
#
# @param [String] source Specifies the URL to download the profile from
# @param [String] ensure Specifies with the profile should exist or not
# @param [String] type Specifies the archive type of the profile
define inspec::profile (
  $source,
  $ensure         = 'present',
  $type           = 'tar.gz',
) {

  include ::inspec

  remote_file { "${name}" :
    ensure => $ensure,
    path   => "${::inspec::config_dir}/${::inspec::downloads_dir}/${name}.${type}",
    source => $source,
  }

  file { "${::inspec::config_dir}/${::inspec::downloads_dir}/${name}.${type}" :
    ensure => 'symlink',
    target => "${::inspec::config_dir}/${::inspec::profiles_dir}/${name}.${type}"
  }

}
