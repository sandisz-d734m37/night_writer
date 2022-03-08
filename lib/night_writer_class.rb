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
  end

  include NightWriteable
end
