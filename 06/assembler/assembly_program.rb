require_relative './line'

class AssemblyProgram
  def initialize(io)
    @io = io
    establish_symbols!
  end

  def to_hack
    each_line
  end

  private
  attr_reader :io

  def establish_symbols!
    parsed_commands.select(&:resolvable?).each(&:resolve!)
  end

  def each_line
    return enum_for(__method__) unless block_given?

    parsed_commands.reject(&:resolvable?).each do |command|
      yield command.to_hack
    end
  end

  def parsed_commands
    @parsed_commands ||= _parsed_commands
  end

  def _parsed_commands
    line_number = 0
    present_lines.map { |line|
      LineParser.new(line, line_number, symbol_table).command.tap do |command|
        unless command.resolvable?
          line_number += 1
        end
      end
    }
  end

  def present_lines
    @present_lines ||= lines
      .lazy
      .select(&:present?)
      .map(&:to_pure_code)
  end

  def lines
    io.each_line.map { |line| Line.new(line) }
  end

  def symbol_table
    @symbol_table ||= SymbolTable.new
  end
end
