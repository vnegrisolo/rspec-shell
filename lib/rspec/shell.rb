require 'rspec/shell/version'
require 'rspec/shell/environment'
require 'rspec/shell/mock'
require 'rspec/shell/mock_expectation'

module Rspec
  module Shell

    def shell
      @shell ||= Environment.new
    end

    def self.included(base)
      base.after { is_expected.to_not include('Should Be Mocked') }
    end
  end
end
