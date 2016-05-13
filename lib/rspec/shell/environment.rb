module Rspec
  module Shell
    class Environment
      def initialize
        @mocks = {}
        @variables = {}
        @inputs = []
      end

      def allow(mock)
        @mocks[mock] || @mocks[mock] = Mock.new(mock)
      end

      def export(variable, value)
        @variables[variable] = value
      end

      def type(*inputs)
        @inputs += inputs
      end

      def run(command, params = '')
        full_command = join(
          @variables.map { |k, v| "export #{k}='#{v}'" },
          @mocks.values.map(&:to_shell),
          ". #{command}.sh",
          "#{command} #{params} <<< $'#{join(@inputs)}'",
          "printenv"
        )

        `#{full_command}`
      end

      def join(*args)
        args.flatten.compact.join("\n")
      end
    end
  end
end

