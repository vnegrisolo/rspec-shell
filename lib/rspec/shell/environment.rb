module Rspec
  module Shell
    class Environment
      attr_reader :files, :mocks, :variables, :inputs

      def initialize
        @files = []
        @mocks = {}
        @variables = {}
        @inputs = []
      end

      def load(*files)
        @files += files
      end

      def expect(mock)
        @mocks[mock] ||= Mock.new(mock)
      end

      def export(variable, value)
        @variables[variable] = value
      end

      def type(*inputs)
        @inputs += inputs
      end

      def to_shell(command)
        [
          variables.map { |k, v| "export #{k}='#{v}'" },
          mocks.values.map(&:to_shell),
          files.map { |file| ". #{file}" },
          "#{command}#{inputs_to_shell}",
          "printenv"
        ].flatten.compact.join("\n")
      end

      def run(command)
        `#{to_shell(command)}`
      end

      private

      def inputs_to_shell
        return if @inputs.empty?

        inputs = @inputs.join("\n")
        " <<< $'#{inputs}'"
      end
    end
  end
end
