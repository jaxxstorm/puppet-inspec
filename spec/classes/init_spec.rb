require 'spec_helper'

describe 'inspec', type: :class do
  RSpec.configure do |c|
    c.default_facts = {
      architecture: 'x86_64',
      operatingsystem: 'CentOS',
      osfamily: 'RedHat',
      operatingsystemrelease: '6.6',
      operatingsystemmajrelease: '7',
      kernel: 'Linux',
    }
  end

  context 'defaults' do
    it { is_expected.to contain_class('inspec') }
    it { is_expected.to contain_class('inspec::install').that_comes_before('Class[inspec::configure]') }
    it { is_expected.to contain_class('inspec::configure') }
    it { is_expected.to contain_class('inspec::params') }
    it { is_expected.to contain_anchor('inspec_first') }
    it { is_expected.to contain_anchor('inspec_final') }
    it { is_expected.to compile.with_all_deps }
  end

  context 'when specifying package repo' do
    let(:params) do
      {
        install_method: 'package',
      }
    end

    it { is_expected.to contain_package('inspec').with(ensure: 'present') }
    it { is_expected.to contain_yumrepo('chef-stable').with(enabled: 1, gpgcheck: 0, baseurl: 'https://packages.chef.io/repos/yum/stable/el/7/x86_64') }
    it { is_expected.to contain_class('inspec::repo') }
    it { is_expected.to contain_class('inspec::repo::yum') }
  end

  context 'when specifying a version' do
    let(:params) do
      {
        package_version: '_value_',
      }
    end

    it { is_expected.to contain_package('inspec').with(ensure: '_value_') }
  end

  context 'when specifying the current branch' do
    let(:params) do
      {
        install_method: 'package',
        package_version: 'latest',
        repo_channel: 'current',
      }
    end

    it { is_expected.to contain_package('inspec').with(ensure: 'latest') }
    it { is_expected.to contain_yumrepo('chef-current').with(enabled: 1, gpgcheck: 0, baseurl: 'https://packages.chef.io/repos/yum/current/el/7/x86_64') }
  end

  context 'when not managing the repo' do
    let(:params) do
      {
        install_method: 'package',
        package_version: 'latest',
        manage_repo: false,
      }
    end

    it { is_expected.to contain_package('inspec').with(ensure: 'latest') }
    it { is_expected.not_to contain_yumrepo('chef-stable') }
  end

  context 'when specifying install a gem' do
    let(:params) do
      {
        install_method: 'gem',
        package_version: 'latest',
      }
    end

    it { is_expected.to contain_package('inspec').with(provider: 'gem', ensure: 'latest') }
  end

  context 'when specifying a config dir' do
    let(:params) do
      {
        config_dir: '/etc/inspec',
        profiles_dir: 'profiles.d',
        downloads_dir: 'downloads',
      }
    end

    it { is_expected.to contain_file('/etc/inspec').with(ensure: 'directory') }
    it { is_expected.to contain_file('/etc/inspec/profiles.d').with(ensure: 'directory') }
    it { is_expected.to contain_file('/etc/inspec/downloads').with(ensure: 'directory') }
  end
end
