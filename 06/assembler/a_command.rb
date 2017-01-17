class ACommand
  def initialize(line, symbol_table)
    @line = line[1..-1]
    @symbol_table = symbol_table
  end

  def inspect
    to_i
  end

  def to_hack
    to_i.to_s(2).rjust(16, '0')
  end

  def resolvable?
    false
  end

  private
  attr_reader :line, :symbol_table

  def to_i
    if line =~ /\A\d+\z/
      line.to_i
    elsif (meaning = symbol_table[line])
      meaning
    else
      symbol_table.add_symbol(line)
    end
  end
end
