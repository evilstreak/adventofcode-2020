require 'ostruct'

group_input = $stdin.read.split(/\n\n/)

puts "Sum of any yes:", group_input
  .map { |group_input|
    group_input.gsub(/\s/, '').split('').uniq.count
  }
  .reduce(&:+)

puts "Sum of every yes:", group_input
  .map { |group_input|
    group_input
      .split(/\n/)
      .map { |person_input| person_input.split('') }
      .reduce(&:&)
      .count
  }
  .reduce(&:+)
