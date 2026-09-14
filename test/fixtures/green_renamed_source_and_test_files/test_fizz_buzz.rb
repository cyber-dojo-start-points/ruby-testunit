require_relative 'fizz_buzz'
require 'test/unit'

class TestFizzBuzz < Test::Unit::TestCase

  def test_life_the_universe_and_everything
    assert_equal 42, fizz_buzz
  end

end
