# Install the yum repo for inspec
class inspec::repo::yum {

  yumrepo { "chef-${inspec::repo_channel}":
    enabled  => 1,
    baseurl  => "${inspec::package_url_base}${inspec::package_url_type}/${inspec::repo_channel}/${inspec::os_family}/${inspec::os_ver}/${inspec::os_arch}",
    gpgcheck => 0, # FIXME: use gpg keys
    name     => "chef-${inspec::repo_channel}",
    descr    => "chef-${inspec::repo_channel}",
    before   => Package[$inspec::package_name]
  }

}
