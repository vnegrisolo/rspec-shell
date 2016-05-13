require 'spec_helper'

RSpec.describe Rspec::Shell do
  it 'has a version number' do
    expect(Rspec::Shell::VERSION).not_to be nil
  end

  describe '#shell' do
    let(:test_class) { Class.new(RSpec::Core::ExampleGroup) { include Rspec::Shell }.new }

    it 'instantiate an Shell Environment' do
      expect(test_class.shell).to be_a(Rspec::Shell::Environment)
    end
  end
end
