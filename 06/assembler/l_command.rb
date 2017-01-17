class LCommand
  def initialize(line, symbol_table, line_number)
    @line = line
    @symbol_table = symbol_table
    @line_number = line_number
  end

  def inspect
    "#<#{self.class} line=#{line} line_number=#{line_number}"
  end

  def resolve!
    symbol_table.add_symbol(line[1..-2], line_number)
  end

  def resolvable?
    true
  end

  private
  attr_reader :line, :symbol_table, :line_number
end
