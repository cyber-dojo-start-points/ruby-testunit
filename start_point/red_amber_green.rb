
lambda { |stdout,stderr,status|
  output = stdout + stderr
  ruby_pattern = Regexp.new('^(\d+) tests, (\d+) assertions, (\d+) failures, (\d+) errors')
  if match = ruby_pattern.match(output)
    # A suite that reported no tests at all did not run anything to be green
    # about. test-unit prints this summary from an at_exit hook, so it appears
    # for an empty test class, for a test file nothing loads, and for a run
    # killed before it got anywhere.
    return :amber if match[1] == '0'
    return :amber if match[4] != '0'
    return :red   if match[3] != '0'
    return :green
  else
    return :amber
  end
}
