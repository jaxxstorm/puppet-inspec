require 'spec_helper'


describe 'inspec', :type => :class do

	RSpec.configure do |c|
    c.default_facts = {
      :architecture               => 'x86_64',
      :operatingsystem            => 'CentOS',
      :osfamily                   => 'RedHat',
      :operatingsystemrelease     => '6.6',
      :operatingsystemmajrelease  => '7',
      :kernel                     => 'Linux',
    }
  end

	context 'defaults' do
		it { should compile }
	end

  context "when install via url by default" do
    it { should contain_file('/tmp/').with(:ensure => 'directory') }
    it { should contain_archive('/tmp/inspec-1.7.1-1.el7.x86_64.rpm').with(:source => 'https://packages.chef.io/stable/el/7/inspec-1.7.1-1.el7.x86_64.rpm')}
    it { should contain_package('inspec').with(:source => '/tmp/inspec-1.7.1-1.el7.x86_64.rpm', :ensure => 'present') }
  end

  context "when providing a custom url" do
    let (:params) {{
      :download_url => 'https://my_url/inspec-1.7.1-1.el7.x86_64.rpm'
    }}
    it { should contain_archive('/tmp/inspec-1.7.1-1.el7.x86_64.rpm').with(:source => 'https://my_url/inspec-1.7.1-1.el7.x86_64.rpm') }
  end

  context "when specifying package repo" do
    let (:params) {{
      :install_method => 'package',
      :package_version => 'latest'
    }}
    it { should contain_package('inspec').with(:ensure => 'latest') }
    it { should contain_yumrepo('chef-stable').with(:enabled => 1, :gpgcheck => 0, :baseurl => 'https://packages.chef.io/repos/yum/stable/el/7/x86_64') }
  end

  context "when specifying the current branch" do
    let (:params) {{
      :install_method => 'package',
      :package_version => 'latest',
      :repo_channel => 'current',
    }}
    it { should contain_package('inspec').with(:ensure => 'latest') }
    it { should contain_yumrepo('chef-current').with(:enabled => 1, :gpgcheck => 0, :baseurl => 'https://packages.chef.io/repos/yum/current/el/7/x86_64') }
  end

  context "when not managing the repo" do
    let (:params) {{
      :install_method => 'package',
      :package_version => 'latest',
      :manage_repo => false
    }}
    it { should contain_package('inspec').with(:ensure => 'latest') }
    it { should_not contain_yumrepo('chef-stable') }
  end


  context "when specifying install a gem" do
    let (:params) {{
      :install_method => 'gem',
      :package_version => 'latest'
    }}
    it { should contain_package('inspec').with(:provider => 'gem', :ensure => 'latest') }
  end

end
