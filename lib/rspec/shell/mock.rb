module Rspec
  module Shell
    class Mock
      attr_reader :name, :output, :expectations, :shell_control

      def initialize(name)
        @name = name
        @output = "'#{name}' Should Be Mocked with='$*'"
        @expectations = []
        @shell_control = "#{name}_ok"
      end

      def with(params)
        expectations.push(MockExpectation.new(params)).last
      end

      def and_return(output)
        @output = output
      end

      def to_shell
        [
          "#{name}() {",
          "#{shell_control}=0",
          expectations_to_shell,
          default_expactation_to_shell,
          '}',
        ].flatten.compact.join("\n")
      end

      private

      def default_expactation_to_shell
        "if [ $#{shell_control} -eq 0 ]; then #{print(output)} fi"
      end

      def expectations_to_shell
        expectations.map do |e|
          "if [ \"$*\" = \"#{e.params}\" ]; then #{shell_control}=1; #{print(e.output)} fi"
        end
      end

      def print(output)
        output && "echo \"#{output.gsub(/"/, '\"')}\";"
      end
    end
  end
end
