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
          captured_stdout = StringIO.new(+'', 'w')
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

# Without this, any run that ends in a failing test carries a line saying
# SimpleCov stopped because of an error that is nothing to do with SimpleCov.
# That is every red run, and it says nothing about the test that failed.
SimpleCov.print_error_status = false

SimpleCov.at_exit do
  # The report is written on green only. test-unit has called exit by the time
  # this runs, so $! holds its SystemExit: successful when every test passed,
  # unsuccessful when one failed. A file that would not even load leaves some
  # other exception here instead, and no SystemExit at all.
  if $!.is_a?(SystemExit) && $!.success?
    SimpleCov::Formatter::FileWriter.new.format(SimpleCov.result)
  end
end
SimpleCov.start
