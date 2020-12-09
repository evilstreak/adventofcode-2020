require 'ostruct'

input = $stdin.read.split(/\n/)

class Computer
  attr_reader :instructions, :instructions_run, :accumulator, :pointer

  def initialize(instructions)
    @instructions = instructions
    @instructions_run = []
    @accumulator = 0
    @pointer = 0
  end

  def run
    while true
      if program_terminated?
        return true
      elsif next_instruction_already_run?
        return false
      else
        step
      end
    end
  end

  def step
    instructions_run << pointer

    case next_instruction.operation
    when 'nop'
      @pointer += 1
    when 'acc'
      @accumulator += next_instruction.value
      @pointer += 1
    when 'jmp'
      @pointer += next_instruction.value
    end
  end

  def next_instruction
    instructions[pointer]
  end

  def next_instruction_already_run?
    instructions_run.include?(pointer)
  end

  def program_terminated?
    next_instruction.nil?
  end
end

instructions = input.map { |instruction_input|
  operation, value = instruction_input.split(' ')
  OpenStruct.new(
    operation: operation,
    value: value.to_i,
  )
}

computer = Computer.new(instructions)
computer.run
puts 'Accumulator value before looping:', computer.accumulator

fixed_computer = instructions
  .count
  .times
  .lazy
  .map { |n|
    if instructions[n].operation == 'nop'
      Computer.new(
        instructions[0...n] +
        [
          OpenStruct.new(
            operation: 'jmp',
            value: instructions[n].value
          )
        ] +
        instructions[(n+1)..-1]
      )
    elsif instructions[n].operation == 'jmp'
      Computer.new(
        instructions[0...n] +
        [
          OpenStruct.new(
            operation: 'nop',
            value: instructions[n].value
          )
        ] +
        instructions[(n+1)..-1]
      )
    end
  }
  .reject(&:nil?)
  .find { |computer| computer.run }

puts 'Accumulator value after terminating:', fixed_computer.accumulator
