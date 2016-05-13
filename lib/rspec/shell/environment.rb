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

      def allow(mock)
        @mocks[mock] ||= Mock.new(mock)
      end

      def export(variable, value)
        @variables[variable] = value
      end

      def type(*inputs)
        @inputs += inputs
      end

      def run(command)
        full_command = [
          variables.map { |k, v| "export #{k}='#{v}'" },
          mocks.values.map(&:to_shell),
          files.map { |file| ". #{file}" },
          "#{command} <<< $'",
          inputs,
          "'",
          "printenv"
        ].flatten.compact.join("\n")

        `#{full_command}`
      end
    end
  end
end
