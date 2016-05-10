require 'spec_helper'

RSpec.describe Rspec::Shell do
  it 'has a version number' do
    expect(described_class::VERSION).not_to be nil
  end

  describe '#shell' do
    let(:test_class) { Class.new { include Rspec::Shell }.new }

    it 'instantiate an Environment for shell' do
      expect(test_class.shell).to be_a(described_class::Environment)
    end
  end
end
