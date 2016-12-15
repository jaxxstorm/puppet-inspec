# Install & Manage Inspec
#
# @example Declaring the class
#   include ::inspec
#
# @param [String] package_name The name of the package to install
# @param [String] package_version The version of the package to install
# @param [String] install_method The method of installing the package
# @param [String] download_path Location to download the package to
# @param [String] download_url_base A base URL to download the package from
# @param [String] download_url A custom download URL to download the package from
# @param [String] os_arch The OS arch of the package to download
# @param [String] package_suffix The suffix of the package to download
# @param [String] manage_repo Whether the package repo should be managed
# @param [String] repo_channel Which repo channel should be used
# @param [String] package_url_base The base url for the chef packages
# @param [String] package_url_type The type of repo for the chef package repo
class inspec (
  $package_name       = $inspec::params::package_name,
  $package_version    = $inspec::params::package_version,
  $install_method     = $inspec::params::install_method,
  $download_path      = $inspec::params::download_path,
  $download_url_base  = $inspec::params::download_url_base,
  $download_url       = $inspec::params::download_url,
  $os_arch            = $inspec::params::os_arch,
  $os_family          = $inspec::params::os_family,
  $os_ver             = $inspec::params::os_ver,
  $package_suffix     = $inspec::params::package_suffix,
  $manage_repo        = $inspec::params::manage_repo,
  $repo_channel       = $inspec::params::repo_channel,
  $package_url_base   = $inspec::params::package_url_base,
  $package_url_type   = $inspec::params::package_url_type,
) inherits inspec::params {

  $real_download_url = pick($download_url, "${download_url_base}${os_family}/${os_ver}/${package_name}-${package_version}.${os_family}${os_ver}.${os_arch}.${package_suffix}")

  anchor { 'inspec_first': } ->
  class { 'inspec::install': } ->
  anchor { 'inspec_final': }

}
