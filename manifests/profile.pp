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
# @param [String] extract Specifies whether the profile should be extracted
# @param [String] extract_path Specifies a custom path to extract profiles to
define inspec::profile (
  $source,
  $ensure         = 'present',
  $extract        = true,
  $extract_path   = undef,
) {

  include ::inspec

  $_profile_dir = pick($extract_path, "${::inspec::config_dir}/${::inspec::downloads_dir}")

  archive { $name:
    ensure       => $ensure,
    source       => $source,
    extract      => $extract,
    extract_path => "${_profile_dir}/${name}",
    creates      => "${_profile_dir}/${name}",
  }

  file { "${_profile_dir}/${name}" :
    ensure => 'symlink',
    target => "${::inspec::config_dir}/${::inspec::profiles_dir}/${name}"
  }

}
