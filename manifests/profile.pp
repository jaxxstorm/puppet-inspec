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
# @param [String] version Specifies the profile version you wish to use
define inspec::profile (
  $source,
  $ensure         = 'present',
  $type           = 'tar.gz',
  $version        = undef,
) {

  include ::inspec

  if $version {
    $_file_name = "${name}-${version}.${type}"
  } else {
    $_file_name = "${name}.${type}"
  }

  remote_file { $name :
    ensure => $ensure,
    path   => "${::inspec::config_dir}/${::inspec::downloads_dir}/${_file_name}",
    source => $source,
  }

  file { "${::inspec::config_dir}/${::inspec::downloads_dir}/${_file_name}" :
    ensure => 'symlink',
    target => "${::inspec::config_dir}/${::inspec::profiles_dir}/${name}.${type}"
  }

}
