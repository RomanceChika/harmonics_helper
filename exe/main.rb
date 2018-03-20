require "harmonics_helper"

if ARGV.length == 0 
  puts "please set file name"
  exit
end
file_name = ARGV[0]
begin
  parser = HarmonicsHelper::Parser.new(file_name)
  prohibit_checker = HarmonicsHelper::ProhibitChecker.new(parser)
  output_formatter = HarmonicsHelper::OutputFormatter.new(prohibit_checker)
  output_formatter.output
rescue Errno::ENOENT => e
  puts "File is Not Found"
end