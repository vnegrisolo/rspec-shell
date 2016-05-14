require 'spec_helper'

RSpec.describe Rspec::Shell::Mock do

  subject(:mock) { described_class.new(:git) }

  describe '#to_shell' do
    subject { mock.to_shell }

    it 'mocks git' do
      is_expected.to include('git() {')
      is_expected.to include('git_ok=0')
      is_expected.to include('if [ $git_ok -eq 0 ]; then echo "\'git\' Should Be Mocked with=\'$*\'"; fi')
      is_expected.to include('}')
    end

    context 'with default output' do
      before { mock.and_return('response') }

      it 'mocks git' do
        is_expected.to include('if [ $git_ok -eq 0 ]; then echo "response"; fi')
      end
    end

    context 'with expectation but no output' do
      before { mock.with('commit') }

      it 'mocks git' do
        is_expected.to include('if [ "$*" = "commit" ]; then git_ok=1;  fi')
      end
    end

    context 'with expectation and output' do
      before { mock.with('commit').and_return('response') }

      it 'mocks git' do
        is_expected.to include('if [ "$*" = "commit" ]; then git_ok=1; echo "response"; fi')
      end
    end
  end
end
