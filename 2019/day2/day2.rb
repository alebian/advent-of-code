class IntcodeComputer
  class Instruction
    def initialize(instruction_pointer, memory)
      @instruction_pointer = instruction_pointer
      @memory = memory
    end
  end

  class Sum < Instruction
    def call
      value1_address = @memory[@instruction_pointer + 1]
      value2_address = @memory[@instruction_pointer + 2]
      return_address = @memory[@instruction_pointer + 3]
      @memory[return_address] = @memory[value1_address] + @memory[value2_address]
    end

    def new_instruction_pointer
      @instruction_pointer + 4
    end
  end

  class Multiplication < Instruction
    def call
      value1_address = @memory[@instruction_pointer + 1]
      value2_address = @memory[@instruction_pointer + 2]
      return_address = @memory[@instruction_pointer + 3]
      @memory[return_address] = @memory[value1_address] * @memory[value2_address]
    end

    def new_instruction_pointer
      @instruction_pointer + 4
    end
  end

  HALT = 99
  INSTRUCTIONS = {
    1 => Sum,
    2 => Multiplication
  }.freeze

  attr_reader :memory

  def initialize(memory)
    @memory = memory
    reset_instruction_pointer
  end

  def execute_program
    while current_opcode != HALT
      instruction = INSTRUCTIONS[current_opcode].new(@instruction_pointer, @memory)
      instruction.call
      @instruction_pointer = instruction.new_instruction_pointer
    end
  end

  private

  def current_opcode
    @memory[@instruction_pointer]
  end

  def reset_instruction_pointer
    @instruction_pointer = 0
  end
end

original_input = [1,0,0,3,1,1,2,3,1,3,4,3,1,5,0,3,2,1,10,19,2,6,19,23,1,23,5,27,1,27,13,31,2,6,31,35,1,5,35,39,1,39,10,43,2,6,43,47,1,47,5,51,1,51,9,55,2,55,6,59,1,59,10,63,2,63,9,67,1,67,5,71,1,71,5,75,2,75,6,79,1,5,79,83,1,10,83,87,2,13,87,91,1,10,91,95,2,13,95,99,1,99,9,103,1,5,103,107,1,107,10,111,1,111,5,115,1,115,6,119,1,119,10,123,1,123,10,127,2,127,13,131,1,13,131,135,1,135,10,139,2,139,6,143,1,143,9,147,2,147,6,151,1,5,151,155,1,9,155,159,2,159,6,163,1,163,2,167,1,10,167,0,99,2,14,0,0]
memory = original_input.dup
memory[1] = 12
memory[2] = 2

computer = IntcodeComputer.new(memory)
computer.execute_program
puts computer.memory[0]

(0..99).each do |i|
  (0..99).each do |j|
    memory = original_input.dup
    memory[1] = i
    memory[2] = j

    computer = IntcodeComputer.new(memory)
    computer.execute_program
    if computer.memory[0] == 19690720
      puts i
      puts j
      puts (100 * i) + j
      return
    end
  end
end

puts 'not found'
