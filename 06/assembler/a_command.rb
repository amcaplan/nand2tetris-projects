class ACommand
  def initialize(line)
    @line = line[1..-1]
  end

  def inspect
    to_i
  end

  def to_hack
    to_i.to_s(2).rjust(16, '0')
  end

  private
  attr_reader :line

  def to_i
    if line =~ /\A\d+\z/
      line.to_i
    else
      raise "not a handled A command: #{line}"
    end
  end
end
