require 'pry'
require_relative 'night_writer_class'

if $PROGRAM_NAME == __FILE__
  NightWriter.new(ARGV).readfile
end
