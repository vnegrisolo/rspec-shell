require 'spec_helper'

RSpec.describe Rspec::Shell::Environment do

  subject(:environment) { described_class.new }

  describe '#load' do
    it 'stores files to be loaded' do
      environment.load('my-shell.sh', 'pair.sh')
      expect(environment.files).to eq(%w(my-shell.sh pair.sh))
    end
  end

  describe '#allow' do
    it 'instantiates a Shell Mock' do
      environment.allow(:git)
      expect(environment.mocks[:git]).to be_a(Rspec::Shell::Mock)
    end
  end

  describe '#export' do
    it 'stores Environment Variable' do
      environment.export('MY_VAR', 'my value')
      expect(environment.variables).to eq('MY_VAR' => 'my value')
    end
  end

  describe '#type' do
    it 'stores user Inputs' do
      environment.type('yes', 'no')
      expect(environment.inputs).to eq(%w(yes no))
    end
  end

  describe '#to_shell' do
    subject { environment.to_shell('pair') }

    it 'calls the command and prints the final environment variables' do
      is_expected.to include('pair')
      is_expected.to include('printenv')
    end

    context 'with files to load' do
      before { environment.load('pair.sh') }

      it 'loads the files' do
        is_expected.to include('. pair.sh')
      end
    end

    context 'with mock git' do
      before { environment.allow(:git).with('commit --amend') }

      it 'calls the command' do
        is_expected.to include('git() {')
        is_expected.to include('if [ "$*" = "commit --amend" ]; then git_ok=1;  fi')
      end
    end

    context 'with mock curl and return something' do
      before { environment.allow(:curl).with('url').and_return('response') }

      it 'calls the command' do
        is_expected.to include('curl() {')
        is_expected.to include('if [ "$*" = "url" ]; then curl_ok=1; echo "response"; fi')
      end
    end

    context 'with variables to export' do
      before { environment.export('KEY', 'user-key') }

      it 'exports variables' do
        is_expected.to include("export KEY='user-key'")
      end
    end

    context 'with user inputs' do
      before { environment.type('yes') }

      it 'adds user inputs' do
        is_expected.to include("pair <<< $'yes'")
      end
    end
  end
end
