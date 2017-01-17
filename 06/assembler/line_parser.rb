require_relative 'a_command'
require_relative 'c_command'
require_relative 'l_command'

class LineParser
  def initialize(line)
    @line = line
  end

  def command
    if is_a_command?
      ACommand.new(line)
    elsif is_c_command?
      CCommand.new(line)
    elsif is_l_command?
      LCommand.new(line)
    else
      raise "not a command!: #{line}"
    end
  end

  private
  attr_reader :line

  def is_a_command?
    line =~ /\A@[#{symbol_chars}]+\z/
  end

  def is_c_command?
    line =~ CCommand::FORMAT
  end

  def is_l_command?
    line =~ /\A\([#{symbol_chars}]+\)\z/
  end

  def symbol_chars
    '\dA-Za-z+\.$\:_'
  end
end
