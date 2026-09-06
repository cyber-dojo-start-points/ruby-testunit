require_relative 'coverage'
require_relative 'hiker'
require 'test/unit'
require 'mocha/test_unit'

class TestHiker < Test::Unit::TestCase

  def test_global_function
    expects(:puts).with('the answer is 42').once
    assert_equal 42, global_answer
  end

  def test_instance_method
    hiker = Hiker.new
    hiker.expects(:puts).with('the answer is 42').once
    assert_equal 42, hiker.instance_answer
  end

  # Example test showing mocha's vocabulary.
  def test_mocha_vocabulary
    # stubs() answers a call, and does not mind how often, or never at all
    stubbed = mock('stubbed')
    stubbed.stubs(:ask).returns(42)
    assert_equal 42, stubbed.ask

    # expects() also requires the call to happen before the test ends
    expected = mock('expected')
    expected.expects(:ask)
    expected.ask

    # with() constrains the arguments, returns() answers the call
    calculator = mock('calculator')
    calculator.expects(:times).with(6, 7).returns(42)
    assert_equal 42, calculator.times(6, 7)

    # once() twice() times(n) never() constrain how often
    counter = mock('counter')
    counter.expects(:tick).twice
    counter.expects(:tock).never
    2.times { counter.tick }

    # raises() makes the call raise instead of answering
    broken = mock('broken')
    broken.stubs(:ask).raises(RuntimeError, 'no answer')
    assert_raise(RuntimeError) { broken.ask }

    # stubs() on an object you already have replaces only the method named,
    # and leaves the rest of that object alone
    numbers = [6, 7]
    numbers.stubs(:size).returns(42)
    assert_equal 42, numbers.size
    assert_equal [6, 7], numbers
  end

end
