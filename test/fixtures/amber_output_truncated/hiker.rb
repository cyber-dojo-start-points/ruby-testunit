# The learner put a print inside a loop to see what was happening, and it
# prints far more than the 50K the runner keeps, so the summary line test-unit
# writes at the end is dropped and no colour can be read from what is left.
5000.times { |i| puts "debug: answer was called, i is #{i}" }

def answer
  6 * 7
end
