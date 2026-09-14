# The name holds no "test", so cyber-dojo.sh parses this file but never
# requires it, and these tests do not run. The assertion is one that would
# fail, so that a green says it really did not run rather than that it ran
# and passed.
require_relative 'hiker'
require 'test/unit'

class SpecHiker < Test::Unit::TestCase

  def test_the_answer_is_three_digits_long
    assert_equal 3, answer.to_s.size
  end

end
