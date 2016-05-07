require 'spec_helper'

describe Rspec::Shell do
  it 'has a version number' do
    expect(Rspec::Shell::VERSION).not_to be nil
  end

  it 'does something useful' do
    expect(false).to eq(true)
  end
end
