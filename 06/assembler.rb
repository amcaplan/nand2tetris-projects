require 'fileutils'
require './assembler/assembly_program'

in_file = ARGV.pop
unless File.exist?(in_file)
  raise ArgumentError, 'Input file does not exist!'
end

out_file = in_file.sub(/\.asm\z/, '.hack')

File.open(in_file) do |file|
  output = AssemblyProgram.new(file).to_hack.to_a.join("\n")
  File.write(out_file, output)
end
