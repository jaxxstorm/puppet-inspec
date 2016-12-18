require 'spec_helper'

describe 'inspec::profile', :type => :define do


  context 'with default set' do
    let(:title) { ('test') }


    context 'specify source' do
      let(:params) {{ 
        :source => 'http://my_url/test.tar.gz'
      }}

      it { should contain_remote_file('test').with(:source => 'http://my_url/test.tar.gz', :path => '/etc/inspec/downloads/test.tar.gz') }
      it { should contain_file('/etc/inspec/downloads/test.tar.gz').with(:ensure => 'symlink', :target => '/etc/inspec/profiles.d/test.tar.gz') }
    end
  end

end
