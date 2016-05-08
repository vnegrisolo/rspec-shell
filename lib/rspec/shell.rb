require 'rspec/shell/version'
require 'rspec/shell/environment'
require 'rspec/shell/mock'
require 'rspec/shell/mock_expectation'

module Rspec
  module Shell

    def mock(*mocks)
      Environment.new(*mocks)
    end
  end
end
