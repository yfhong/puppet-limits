require 'spec_helper'

describe 'limits' do
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) do
          facts
        end

        context "limits class without any parameters" do
          let(:params) {{ }}

          it { is_expected.to compile.with_all_deps }

          it { is_expected.to contain_class('limits::params') }
          it { is_expected.to contain_class('limits::install').that_comes_before('limits::config') }
          it { is_expected.to contain_class('limits::config') }
          it { is_expected.to contain_class('limits::service').that_subscribes_to('limits::config') }

          it { is_expected.to contain_service('limits') }
          it { is_expected.to contain_package('limits').with_ensure('present') }
        end
      end
    end
  end

  context 'unsupported operating system' do
    describe 'limits class without any parameters on Solaris/Nexenta' do
      let(:facts) {{
        :osfamily        => 'Solaris',
        :operatingsystem => 'Nexenta',
      }}

      it { expect { is_expected.to contain_package('limits') }.to raise_error(Puppet::Error, /Nexenta not supported/) }
    end
  end
end
