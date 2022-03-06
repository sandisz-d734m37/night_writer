require_relative 'translatable'
require_relative 'night_writeable'
class NightWriter
  attr_reader :message, :braille
  def initialize(args)
    @message = File.open(args[0], "r")
    @braille = File.open(args[1], "w")
  end

  include Translatable

  def readfile
  to_translate = @message.read
  @braille.write(translate_to_braille(to_translate))
  @message.close
  @braille.close
  print_to_terminal
  # binding.pry
  end

  include NightWriteable

  # def count_characters(file)
  #   text = File.read(file)
  #   text = remove_unwanted_char(text)
  #   text.length
  # end
  #
  # def print_to_terminal
  #   puts "Created file '#{ARGV[1]}' containing #{count_characters(@message)} characters"
  # end
end
