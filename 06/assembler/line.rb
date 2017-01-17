require_relative './line_parser.rb'

class Line
  def initialize(line)
    @line = line
  end

  def present?
    !to_pure_code.empty?
  end

  def to_pure_code
    without_comments(without_whitespace).chomp
  end

  private
  attr_reader :line

  def without_whitespace
    line.gsub(/\s/, '')
  end

  def without_comments(string)
    string.sub(/\/\/.*\Z/, '')
  end
end
