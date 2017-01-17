require_relative './line'

class AssemblyProgram
  def initialize(io)
    @io = io
  end

  def to_hack
    each_line
  end

  private
  attr_reader :io

  def each_line
    return enum_for(__method__) unless block_given?
    present_lines.each do |line|
      command = LineParser.new(line).command
      yield command.to_hack
    end
  end

  def present_lines
    lines
      .select(&:present?)
      .map(&:to_pure_code)
  end

  def lines
    io.each_line.map { |line| Line.new(line) }
  end
end
