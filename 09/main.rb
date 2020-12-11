input = $stdin.read.split(/\n/).map(&:to_i)

def first_without_property(sequence, cycle_length)
  sequence.each_cons(cycle_length + 1).find { |*preamble, number|
    preamble.combination(2).lazy.map { |a, b| a + b }.all? { |x|
      number != x
    }
  }.last
end

def encryption_weakness(sequence, target)
  search_space = sequence.take_while { |n| n < target }

  contiguous_sequence = (2..search_space.count)
    .lazy
    .flat_map { |length|
      search_space.each_cons(length).to_a
    }
    .find { |cs| cs.reduce(&:+) == target }

  contiguous_sequence.min + contiguous_sequence.max
end

target = first_without_property(input, 25)

puts "First number without sum property:", target
puts "Encryption weakness:", encryption_weakness(input, target)
