require 'simplecov'
require 'simplecov-console'
require 'stringio'

module SimpleCov
  module Formatter
    class FileWriter
      def format(result)
        stdout = capture_stdout {
          SimpleCov::Formatter::Console.new.format(result)
        }
        `mkdir #{report_dir} 2> /dev/null`
        IO.write("#{report_dir}/coverage.txt", stdout)
      end
      def report_dir
        "#{ENV['CYBER_DOJO_SANDBOX']}/report"
      end
      def capture_stdout
        begin
          uncaptured_stdout = $stdout
          captured_stdout = StringIO.new('', 'w')
          $stdout = captured_stdout
          yield
          $stdout.string
        ensure
          $stdout = uncaptured_stdout
        end
      end
    end
  end
end

SimpleCov.command_name "Test::Unit"
SimpleCov.at_exit do
  # I'd like to only write the coverage report if the
  # traffic-light is green but it seems there is no way.
  if $!.is_a?(SystemExit) # !amber-traffic-light
    SimpleCov::Formatter::FileWriter.new.format(SimpleCov.result)
  end
end
SimpleCov.start
