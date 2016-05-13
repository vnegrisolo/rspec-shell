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
end
