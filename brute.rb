# Brute Force
# Takes a string and a pattern and returns the index of the pattern in the string,
# or returns "not found"

def brute_search string, pattern
  pattern_length = pattern.length
  for string_index in (0... string.length)
    match_count = 0
    loop do
      # if a non-match is found, then break.
      break if string[string_index + match_count] != pattern[match_count]
      # if it wasn't a non-match, it must be a match!
      match_count += 1
      # if match_count reaches the length of the pattern, you've found your pattern!
      # return the index in string where the pattern begins
      return string_index if match_count == pattern_length
    end
  end
  return "not found"
end

test_string = "Alexs-MacBook-Pro-2:app aw$ cd
  Alexs-MacBook-Pro-2:~ aw$ ks
  -bash: ks: command not found
  Alexs-MacBook-Pro-2:~ aw$ ls
  Applications	Documents	Library		Music		Public
  Desktop		Downloads	Movies		Pictures
  Alexs-MacBook-Pro-2:~ aw$ cd Desktop/
  Alexs-MacBook-Pro-2:Desktop aw$ ruby brute_force.rb

  Brute Force Right to Left Test:

  Pattern at index 13
  Pattern at index not found
  Alexs-MacBook-Pro-2:Desktop aw$ "

test_pattern = "Force"

start = Time.now

1000.times do
  brute_search test_string, test_pattern
end

finish = Time.now

puts finish - start

start = Time.now
