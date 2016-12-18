# Install & Manage Inspec
#
# @example Declaring the class
#   include ::inspec
#
# @param [String] package_name The name of the package to install
# @param [String] package_version The version of the package to install
# @param [String] install_method The method of installing the package
# @param [String] os_arch The OS arch of the package to download
# @param [String] config_dir The configuration directory for inspec
# @param [String] profiles_dir Directory to place inspec profiles
# @param [String] downloads_dir Directory to place downloaded profiles
# @param [String] purge Whether to purge config directories not managed by Puppet
# @param [String] manage_repo Whether the package repo should be managed
# @param [String] repo_channel Which repo channel should be used
# @param [String] package_url_base The base url for the chef packages
# @param [String] package_url_type The type of repo for the chef package repo
class inspec (
  $package_name       = $inspec::params::package_name,
  $package_version    = $inspec::params::package_version,
  $install_method     = $inspec::params::install_method,
  $os_arch            = $inspec::params::os_arch,
  $os_family          = $inspec::params::os_family,
  $os_ver             = $inspec::params::os_ver,
  $config_dir         = $inspec::params::config_dir,
  $profiles_dir       = $inspec::params::profiles_dir,
  $downloads_dir      = $inspec::params::downloads_dir,
  $purge              = $inspec::params::purge,
  $manage_repo        = $inspec::params::manage_repo,
  $repo_channel       = $inspec::params::repo_channel,
  $package_url_base   = $inspec::params::package_url_base,
  $package_url_type   = $inspec::params::package_url_type,
) inherits inspec::params {


  validate_bool($purge)

  anchor { 'inspec_first': } ->
  class { 'inspec::install': } ->
  class { 'inspec::configure': } ->
  anchor { 'inspec_final': }

}
