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
  end

end
