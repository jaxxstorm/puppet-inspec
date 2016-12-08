require 'spec_helper'

describe 'inspec::profile', :type => :define do


  context 'with default set' do
    let(:title) { ('test') }


    context 'specify source' do
      let(:params) {{ 
        :source => 'http://my_url/test.tar.gz'
      }}

      it { should contain_archive('test').with(:source => 'http://my_url/test.tar.gz', :extract_path => '/etc/inspec/downloads/test', :creates => '/etc/inspec/downloads/test') }
      it { should contain_file('/etc/inspec/downloads/test').with(:ensure => 'symlink', :target => '/etc/inspec/profiles.d/test') }
    end

    context 'with custom extract_dir' do
      let(:params) {{
        :source => 'http://my_url/test.tar.gz',
        :extract_path => '/etc/foo',
      }}
      it { should contain_archive('test').with(:source => 'http://my_url/test.tar.gz', :extract_path => '/etc/foo/test', :creates => '/etc/foo/test') }
      it { should contain_file('/etc/foo/test').with(:ensure => 'symlink', :target => '/etc/inspec/profiles.d/test') }
    end    
  end

end
