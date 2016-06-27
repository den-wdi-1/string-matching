#Basic Harspool using simplified bad match table:
# The algorithm simply jumps forward by
# pattern_length if char not in pattern is found
# function accepts a string and a pattern and returns the index in the string where
# the pattern first occurs, or "not found"

class Harspool
  def initialize(options)
    @string         = options[:string]   || ""
    @pattern        = options[:pattern]  || ""
    @alphabet       = options[:alphabet] || ""
    @pattern_length = @pattern.length
    @letters_table  = letters_table
  end

  # Generates hash table with keys as all chars in pattern, and values as true
  def letters_table
    table = {}
    @alphabet.split('').each do |char|
      table[char] = @pattern_length
    end
    @pattern.each_char.with_index { |char, index| table[char] = @pattern_length - index - 1}
    table
  end

  def iterate
    string_index = @pattern_length - 1
    while string_index < @string.length
      match_count = 0
      loop do
        # if a non-match is found, then break.
        break if @string[string_index - match_count] != @pattern[(@pattern_length - 1 - match_count)]
        # if it wasn't a non-match, it must be a match!
        match_count += 1
        # if that match_count reaches the lenght of the pattern, you found the pattern!
        # return the index in string where the pattern begins
        return string_index - (@pattern_length - 1) if match_count == @pattern_length
      end
      if @letters_table[@string[string_index]]
        string_index += 1
      else
        string_index += @pattern_length
      end
    end
    return "not found"
  end
end

string = "lexs-MacBook-Pro-2:app aw$ cd
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

pattern = "Force"

alphabet = "!\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstuvwxyz{|}~"
start = Time.now
1000.times do
  brute_search = Harspool.new({string: string, pattern: pattern, alphabet: alphabet})
end
finish = Time.now

puts finish - start
