input = $stdin.read.split(/\n/)

class BagType
  attr_reader :colour, :held_by, :contents

  def initialize(colour)
    @colour = colour
    @held_by = []
    @contents = {}
  end

  def add_holder(other_type)
    held_by << other_type
  end

  def add_contents(other_type, quantity)
    contents[other_type] = quantity
  end

  def eventually_held_by
    (held_by + held_by.flat_map(&:eventually_held_by)).uniq
  end

  def bags_contained
    contents.map { |other_bag_type, quantity|
      (other_bag_type.bags_contained + 1) * quantity
    }.reduce(0, &:+)
  end
end

bag_types = Hash.new { |hash, colour|
  hash[colour] = BagType.new(colour)
}

input.map { |bag_type_input|
  colour, contents_input = bag_type_input.split(' bags contain ')
  bag_type = bag_types[colour]

  contents_input.scan(/((\d+) ([\w ]+)) bags?/).each do |_, quantity, other_colour|
    other_bag_type = bag_types[other_colour]
    bag_type.add_contents(other_bag_type, quantity.to_i)
    other_bag_type.add_holder(bag_type)
  end
}

puts 'Number of bag colours that eventually contain shiny gold', bag_types['shiny gold'].eventually_held_by.count
puts 'Number of bags held in shiny gold bag', bag_types['shiny gold'].bags_contained
