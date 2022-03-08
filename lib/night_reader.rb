require 'pry'
require_relative 'night_reader_class'

if $PROGRAM_NAME == __FILE__
  NightReader.new(ARGV).readfile
end
