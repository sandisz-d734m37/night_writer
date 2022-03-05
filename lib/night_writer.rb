require 'pry'
class NightWriter
  attr_reader :message, :braille
  def initialize(args)
    @message = File.open(args[0], "r")
    @braille = File.open(args[1], "w")
  end

  def readfile
  nothing = @message.read
  @braille.write(nothing.upcase)
  @message.close
  @braille.close
  print_to_terminal
  # binding.pry
  end

  def count_characters(file)
    text = File.read(file)
    text.length
  end

  def print_to_terminal
    puts "Created file '#{ARGV[1]}' containing #{count_characters(@braille)} characters"
  end
end

if $PROGRAM_NAME == __FILE__
  NightWriter.new(ARGV).readfile
end
