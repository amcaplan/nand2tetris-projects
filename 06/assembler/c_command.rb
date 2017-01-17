class CCommand
  letters_and_numbers = '[-!]?[ADM01]'
  operations = '-+&\|'
  FORMAT = /\A((?<dest>[ADM]{0,3})=)?(?<comp>#{letters_and_numbers}([#{operations}][#{letters_and_numbers}])?)(;(?<jump>J\w{2}))?\z/

  DESTS = {
    'A' => 0,
    'D' => 1,
    'M' => 2
  }

  COMPS = {
    '0'   => '0101010',
    '1'   => '0111111',
    '-1'  => '0111010',
    'D'   => '0001100',
    'A'   => '0110000',
    '!D'  => '0001101',
    '!A'  => '0110001',
    '-D'  => '0001111',
    '-A'  => '0110011',
    'D+1' => '0011111',
    'A+1' => '0110111',
    'D-1' => '0001110',
    'A-1' => '0110010',
    'D+A' => '0000010',
    'D-A' => '0010011',
    'A-D' => '0000111',
    'D&A' => '0000000',
    'D|A' => '0010101',
    'M'   => '1110000',
    '!M'  => '1110001',
    '-M'  => '1110011',
    'M+1' => '1110111',
    'M-1' => '1110010',
    'D+M' => '1000010',
    'D-M' => '1010011',
    'M-D' => '1000111',
    'D&M' => '1000000',
    'D|M' => '1010101'
  }.tap { |calcs| calcs.default_proc = ->(_, key){raise "Not a recognized computation: #{key}"} }

  JUMPS = {
    'JGT' => '001',
    'JEQ' => '010',
    'JGE' => '011',
    'JLT' => '100',
    'JNE' => '101',
    'JLE' => '110',
    'JMP' => '111'
  }.tap { |jumps| jumps.default = '000' }

  def initialize(line)
    @line = line
  end

  def inspect
    {
      comp: comp,
      dest: dest,
      jump: jump
    }
  end

  def to_hack
    "111#{comp}#{dest}#{jump}"
  end

  def resolvable?
    false
  end

  private
  attr_reader :line

  def dest
    '000'.tap do |out|
      String(parsed[:dest]).upcase.each_char do |location|
        out[DESTS[location]] = '1'
      end
    end
  end

  def comp
    COMPS[String(parsed[:comp]).upcase]
  end

  def jump
    JUMPS[String(parsed[:jump]).upcase]
  end

  def parsed
    @parsed ||= FORMAT.match(line)
  end
end
