require_relative 'hiker'
require 'test/unit'

class TestHiker < Test::Unit::TestCase

  def test_life_the_universe_and_everything
    assert_equal 42, answer
  end

  def test_the_answer_is_not_the_question
    assert_not_equal '6 * 7', answer
  end

end
