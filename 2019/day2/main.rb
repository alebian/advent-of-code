require '../../helpers'

INPUT = Helpers.read_input(separator: ',').map(&:to_i)

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


memory = INPUT.dup
memory[1] = 12
memory[2] = 2

computer = IntcodeComputer.new(memory)
computer.execute_program
puts computer.memory[0]

(0..99).each do |i|
  (0..99).each do |j|
    memory = INPUT.dup
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
