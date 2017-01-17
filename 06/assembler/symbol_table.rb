class SymbolTable
  BUILTIN_SYMBOLS = {
    'SP'     => 0,
    'LCL'    => 1,
    'ARG'    => 2,
    'THIS'   => 3,
    'THAT'   => 4,
    'SCREEN' => 16384,
    'KBD'    => 24576
  }
  (0..15).each_with_object(BUILTIN_SYMBOLS) do |num, hash|
    hash["R#{num}"] = num
  end

  def initialize
    @symbols = BUILTIN_SYMBOLS.dup
    @pointer = 15
  end

  def add_symbol(symbol, line_number=nil)
    current_symbol = symbols[symbol.upcase]
    if current_symbol
      raise 'Symbol already used!' unless current_symbol == line_number
    else
      new_symbol(symbol, line_number)
    end
  end

  def [](symbol)
    symbols[symbol.upcase]
  end

  private
  attr_reader :symbols

  def new_symbol(symbol, line_number=nil)
    symbols[symbol.upcase] = (line_number || @pointer += 1)
  end
end
