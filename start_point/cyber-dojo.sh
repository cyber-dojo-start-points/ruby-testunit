set -e

# --------------------------------------------------------------
# Text files under /sandbox are automatically returned...
source ~/cyber_dojo_fs_cleaners.sh
export REPORT_DIR=${CYBER_DOJO_SANDBOX}/report
function cyber_dojo_enter()
{
  # 1. Only return _newly_ generated reports.
  cyber_dojo_reset_dirs ${REPORT_DIR}
}
function cyber_dojo_exit()
{
  # 2. Remove text files we don't want returned.
  cyber_dojo_delete_dirs coverage # ...
  #cyber_dojo_delete_files ...
}
cyber_dojo_enter
trap cyber_dojo_exit EXIT SIGTERM
# --------------------------------------------------------------

# turn off colour for new coverage report
export NO_COLOR=1

# All your tests run in ONE ruby process, so test-unit gathers them into a
# single suite and prints one summary counting every test in every file.
#
# The two lines below use different patterns because they do different jobs.
RUN_TESTS=''

# Parse every .rb file, at any depth, whether or not anything requires it yet.
# A file you are partway through writing then reports its syntax error, naming
# the file and the line, rather than being passed over in silence because
# nothing happens to require it. Parsing does not run any of it.
RUN_TESTS+='Dir.glob("**/*.rb").sort.each { |rb| RubyVM::InstructionSequence.compile_file(rb) };'

# Then load every file whose name contains "test", at any depth, so tests you
# put in a sub-directory run too. A test file whose name does NOT contain
# "test" is still parsed by the line above, but its tests will not run.
RUN_TESTS+='Dir.glob("**/*test*.rb").sort.each { |rb| require File.expand_path(rb) };'

ruby -e "${RUN_TESTS}"
