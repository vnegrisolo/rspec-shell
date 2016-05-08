module Rspec
  module Shell
    class Environment
      def initialize(*mocks)
        @mocks = mocks.map { |mock| [mock, Mock.new(mock)] }.to_h
        @variables = {}
        @answers = []
      end

      def allow(mock)
        @mocks[mock]
      end

      def export(variable, value)
        @variables[variable] = value
      end

      def type(*answers)
        @answers += answers
      end

      def run(command, params = '')
        full_command = join(
          @variables.map { |k, v| "export #{k}='#{v}'" },
          @mocks.values.map(&:to_shell),
          ". #{command}.sh",
          "#{command} #{params} <<< $'#{join(@answers)}'",
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

