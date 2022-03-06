require 'pry'
require_relative 'night_writeable'
require_relative 'untranslatable'

class NightReader
  def initialize(args)
    @braille = File.open(args[0], 'r')
    @message = File.open(args[1], 'w')
  end

  include Untranslatable

  def readfile
  to_translate = @braille.read
  @message.write(to_translate)
  @braille.close
  @message.close
  print_to_terminal
  end

  include NightWriteable
end
