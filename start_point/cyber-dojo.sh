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

# Load every test file into a SINGLE ruby process so test-unit aggregates them
# into one suite with one summary line. Running each file in its own process
# (the previous behaviour) printed one summary per file, which a single-summary
# red_amber_green.rb lambda mis-reads (eg green when a later file failed). A
# file that fails to load (eg a syntax error) raises during require and aborts
# before the suite runs, so it emits no summary line and correctly yields amber.
ruby -e 'Dir.glob("*test*.rb").sort.each { |file| require File.expand_path(file) }' || true
