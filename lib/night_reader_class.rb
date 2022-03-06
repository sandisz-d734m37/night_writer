require 'pry'

class NightReader
  def initialize(args)
    @braille = File.open(args[0], 'r')
    @og_message = File.open(args[1], 'w')
  end

  def readfile
  to_translate = @braille.read
  @og_message.write(to_translate.capitalize)
  @braille.close
  @og_message.close
  end
end
