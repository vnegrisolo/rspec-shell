require 'spec_helper'

RSpec.describe Rspec::Shell::Environment do
  describe '#load' do
    it 'stores files to be loaded' do
      expect(described_class.new.load('my-shell.sh', 'pair.sh')).to eq(%w(my-shell.sh pair.sh))
    end
  end

  describe '#allow' do
    it 'instantiates a Shell Mock' do
      expect(described_class.new.allow(:git)).to be_a(Rspec::Shell::Mock)
    end
  end

  describe '#export' do
    it 'stores Environment Variable' do
      expect(described_class.new.export('MY_VAR', 'my value')).to eq('my value')
    end
  end

  describe '#type' do
    it 'stores user Inputs' do
      expect(described_class.new.type('yes', 'no')).to eq(%w(yes no))
    end
  end
end
