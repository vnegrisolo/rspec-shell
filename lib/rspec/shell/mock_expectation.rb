module Rspec
  module Shell
    class MockExpectation
      attr_accessor :params, :output

      def initialize(params)
        @params = params
      end

      def and_return(output)
        @output = output
      end
    end
  end
end
