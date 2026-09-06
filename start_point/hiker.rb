# The starting files are unrelated to the exercise.
#
# They simply show syntax for writing and testing
#  o) a global function, which logs the answer it returns
#  o) an instance method, which delegates to the global function
# Pick the style that best fits the exercise.
# Then delete the other one, along with this comment!

def global_answer
  answer = 6 * 9
  puts "the answer is #{answer}"
  answer
end

class Hiker

  def instance_answer
    global_answer
  end

end
