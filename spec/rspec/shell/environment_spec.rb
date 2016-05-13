require 'spec_helper'

RSpec.describe Rspec::Shell::Environment do
  describe '#allow' do
    it 'instantiate a Shell Mock' do
      expect(described_class.new.allow(:git)).to be_a(Rspec::Shell::Mock)
    end
  end

  describe '#export' do
    it 'store Environment Variable' do
      expect(described_class.new.export('MY_VAR', 'my value')).to eq('my value')
    end
  end

  describe '#type' do
    it 'store user Inputs' do
      expect(described_class.new.type('yes', 'no')).to eq(%w(yes no))
    end
  end
end
